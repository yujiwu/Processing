/* 
Author: Yujie Wu
Date: Jan. 10th, 2023
Abstract: Fluid Dynamics Simulation in 2D space
References: But How DO Fluid Simulations Work? https://www.youtube.com/watch?v=qsYE1wMEMPA
            Real-Time Fluid Dynamics for Games, Jos Stam, 2003
            Fluid Simulation for Dummies, Mike Ash, 2006
            MSAFluid: 
            https://www.memo.tv/works/msafluid/
            https://github.com/memo/p5-MSAFluid/blob/master/examples/MSAFluidDemo/MSAFluidDemo.pde
            (Fluid Simulation Algorithm)
            https://github.com/memo/p5-MSAFluid/blob/6873c94c277cdd9fd45827fbe8027533cd331baa/src/msafluid/MSAFluidSolver2D.java#L736
            (Fluid Core Algorithm)
*/

class fluid2D {
    // n is the size of each square
    int width, height, n, numX, numY;
    float dt, viscosity;
    float [] rho, rho0;
    float [] vX, vY, vX0, vY0, temp;

    final static int    default_n = 10;
  	final static float  default_dt = 0.1;
  	final static float  default_visc = 0.0001;
  	final static int    default_solver_interation = 20;

    fluid2D(int width, int height){
        this.width = width;
        this.height = height;
        n = default_n;
        dt = default_dt;
        viscosity = default_visc;
        //numX, numY means the number of squares in x-direction and y-direction
        numX = width / n;
        numY = height / n;
        rho = new float [numX * numY]; 
        rho0 = new float [numX * numY];
        vX = new float [numX * numY];
        vY = new float [numX * numY];
        vX0 = new float [numX * numY]; 
        vY0 = new float [numX * numY];
    }

    fluid2D(int width, int height, int n, float dt, float viscosity){
        this.width = width;
        this.height = height;
        this.n = n;
        this.dt = dt; 
        this.viscosity = viscosity;
        
        numX = width / n;
        numY = height / n;
        rho = new float [numX * numY]; 
        rho0 = new float [numX * numY];
        vX = new float [numX * numY];
        vY = new float [numX * numY];
        vX0 = new float [numX * numY]; 
        vY0 = new float [numX * numY];
    }

    void addSource(int i, int j, float [] f, float amt) {
		f[index(i,j)] += amt;
	}

    void addGravity(float fallingSpeed){
        for (int i = 0; i < numX; i++){
            for (int j = 0; j < numY; j++) {
                if (rho[index(i,j)] > 0) vY[index(i,j)] += fallingSpeed;
            }
        }
    }

    void stepUpdate(){
        velocitySolver();
        densitySolver();
    }

    void velocitySolver(){
        swapVX();
        swapVY();
        diffuse(vX0, vX, 1);
        diffuse(vY0, vY, 2);
        cleanDiv(vX, vY, vX0, vY0);
        
        swapVX();
        swapVY();
        advect(vX0, vX, vX0, vY0, 1);
        advect(vY0, vY, vX0, vY0, 2);
        cleanDiv(vX, vY, vX0, vY0);
    }

    void densitySolver(){
        swapRho();
        diffuse(rho0, rho, 0);
        swapRho();
        advect(rho0, rho, vX, vY, 0);
    }

    void renderVelocity(int magnify){
        float vx, vy, len, sine, cosine, theta;
        for (int i = 0; i < numX; i++){
            for (int j = 0; j < numY; j++) {
                vx = vX[index(i,j)];
                vy = vY[index(i,j)];
                len = sqrt(vx*vx + vy*vy);
                sine = vy / len;
                cosine = vx/ len;
                theta = asin(sine);
                if (sine < 0 && cosine < 0) stroke(-sine*255, 0, 0);
                else if (sine < 0 && cosine > 0) stroke(-sine*255, cosine*255, 0);
                else if (sine > 0 && cosine < 0) stroke(0, 0, sine*255);
                else stroke(0, cosine*255, sine*255);

                pushMatrix();
                translate(i*n, j*n);
                rotate(theta);
                line(0, 0, len*magnify, 0);
                line(len*magnify, 0, len - 1, -1);
                line(len*magnify, 0, len - 1, 1);
                popMatrix();
            }
        }
    }

    void renderDensity(){
        for (int i = 0; i < numX; i++){
            for (int j = 0; j < numY; j++) {
                fill(255-rho[index(i,j)]);
                noStroke();
                square(i*n, j*n, n);   
            }
        }
    }

    void linearDecay(float decayRate){
        for (int i = 0; i < numX; i++){
            for (int j = 0; j < numY; j++) {
                rho[index(i,j)] -= decayRate;
                if (rho[index(i,j)] < 0) rho[index(i,j)] = 0;
            }
        }
    }

    void hyperbolicDecay(float decayRate){
        for (int i = 0; i < numX; i++){
            for (int j = 0; j < numY; j++) {
                rho[index(i,j)] -= decayRate / (frameCount + 1);
                if (rho[index(i,j)] < 0) rho[index(i,j)] = 0;
            }
        }
    }

    /*------------------Core Code-------------------*/

    void diffuse(float [] f0, float [] f, int s){
        float a = dt * viscosity * (numX-2) * (numY-2);
        for (int iteration = 0; iteration < default_solver_interation; iteration++){
            for (int i = 1; i <= numX-2; i++){
                for (int j = 1; j <= numY-2; j++) {
                    f[index(i,j)] = (f0[index(i,j)] + a * 
                    (f[index(i-1,j)] + f[index(i+1,j)] + f[index(i,j-1)] + f[index(i,j+1)])) / (1 + 4*a);
                }
            }
            setBoundary(f, s);
        }
    }

    void advect(float [] f0, float [] f, float [] vX, float [] vY, int s){
        float x, y, fracX, fracY;
        int intX, intY;
        float interm1, interm2;
        for (int i = 1; i <= numX-2; i++){
            for (int j = 1; j <= numY-2; j++) {
                // (x,y) is the position where (i,j) comes from (backtrace)
                x = i - dt * numX * vX[index(i,j)];
                y = j - dt * numX * vY[index(i,j)];
                // dealing with the boundary
                if (x < 0.5) x = 0.5;
                if (x > numX - 1.5) x = numX - 1.5;
                if (y < 0.5) y = 0.5;
                if (y > numY - 1.5) y = numY - 1.5;

                intX = (int) x;
                intY = (int) y;
                fracX = x - intX;
                fracY = y - intY;
                
                // calculate the density for next frame, which comes from the combination of the current densities 
                interm1 = (1-fracX)*f0[index(intX, intY)] + fracX*f0[index(intX+1, intY)];
                interm2 = (1-fracX)*f0[index(intX, intY+1)] + fracX*f0[index(intX+1, intY+1)];
                f[index(i,j)] = (1-fracY)*interm1 + fracY*interm2;
            }
        }
        setBoundary(f,s);
    }

    // cleaning divergence because we assume the fluid is incompressible
    // Note v is the vector field of velocity 
    void cleanDiv(float [] vX, float [] vY, float [] div, float [] p){
        for (int i = 1; i <= numX-2; i++) {
            for (int j = 1; j <= numY-2; j++) {
                div[index(i,j)] = -(vX[index(i+1,j)] - vX[index(i-1,j)] 
                                 + vY[index(i,j+1)] - vY[index(i,j-1)]) / (2 * numX);    
                p[index(i,j)] = 0;
            }
        }
        setBoundary(div, 0);
        setBoundary(p, 0);

        // calculating the p-space, checkout the helmholtz Therorem for more details
        for (int iteration = 0; iteration < default_solver_interation; iteration++) {
            for (int i = 1; i <= numX-2; i++) {
                for (int j = 1; j <= numY-2; j++) {
                    p[index(i,j)] = (p[index(i+1,j)] + p[index(i-1,j)] 
                                   + p[index(i,j+1)] + p[index(i,j-1)] + div[index(i,j)]) / 4;
                }
            }
            setBoundary(p, 0);
        }

        // calculate the gradient of p-space and subtract it from the vector field of velocity
        for (int i = 1; i <= numX-2; i++) {
            for (int j = 1; j <= numY-2; j++) {
                vX[index(i,j)] -= numX * (p[index(i+1,j)] - p[index(i-1,j)]) / 2;
                vY[index(i,j)] -= numX * (p[index(i,j+1)] - p[index(i,j-1)]) / 2;
            }
        }
        setBoundary(vX, 1);
        setBoundary(vY, 2);
    }

    // s may equal 0, 1, 2 
    // 0: scalar field
    // 1: vector field x
    // 2: vector field y
    void setBoundary(float [] field, int s){
        //top and bottom boundary
        for (int i = 1; i <= numX-2; i++) {
            field[index(i, 0)] = s == 2 ? -field[index(i, 1)] : field[index(i, 1)];
            field[index(i, numY-1)] =  s == 2 ? -field[index(i, numY-2)] : field[index(i, numY-2)];
        }

        //left and right boundary
        for (int j = 1; j <= numY-2; j++) {
            field[index(0, j)] = s == 1 ? -field[index(1, j)] : field[index(1, j)];
            field[index(numX-1, j)] = s == 1 ? -field[index(numX-2, j)] : field[index(numX-2, j)];
        }

        //four corners
        field[index(0, 0)] = (field[index(1, 0)] + field[index(0, 1)]) / 2;
        field[index(0, numY-1)] = (field[index(1, numY-1)] + field[index(0, numY-2)]) / 2;
        field[index(numX-1, 0)] = (field[index(numX-2, 0)] + field[index(numX-1, 1)]) / 2;
        field[index(numX-1, numY-1)] = (field[index(numX-2, numY-1)] + field[index(numX-1, numY-2)]) / 2;
    }

    void swapVX(){
        temp = vX;
        vX = vX0;
        vX0 = temp;
    }

    void swapVY(){
        temp = vY;
        vY = vY0;
        vY0 = temp;
    }

    void swapRho(){
        temp = rho;
        rho = rho0;
        rho0 = temp;
    }

    int index(int i, int j){
        return i + numX * j;
    }

}
