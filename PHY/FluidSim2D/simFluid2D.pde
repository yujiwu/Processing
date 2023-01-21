fluid2D fluid;

void setup() {
    size(600, 500);
    background(255);
    // fluid = new fluid2D(width, height, 5, 0.1, 0.0001);
    fluid = new fluid2D(width, height, 10, 0.1, 0.0001);
    // fluid = new fluid2D(width, height, 2, 0.1, 0.0001);
}

void draw() {
    // velocityFieldSim();
    fluidSim();
}

void velocityFieldSim(){
    background(255);
    fluid.stepUpdate();
    // render velocity with magnifying velocity at each position 50 times
    fluid.renderVelocity(50);
}

void fluidSim(){
    fluid.stepUpdate();
    fluid.addGravity(0.001);
    fluid.renderDensity();
    // faster decay with param decayRate
    // fluid.linearDecay(0.1);
    // slower decay with param decayRate
    // fluid.hyperbolicDecay(1);
}

void mouseDragged(){
    fluid.addSource(mouseX/fluid.n, mouseY/fluid.n, fluid.rho, 200);
    float vx = (mouseX - pmouseX) / 10;
    float vy = (mouseY - pmouseY) / 10;
    fluid.addSource(mouseX/fluid.n, mouseY/fluid.n, fluid.vX, vx);
    fluid.addSource(mouseX/fluid.n, mouseY/fluid.n, fluid.vY, vy);
}


