class Ball implements MovingObj{
    PVector pos; // position
    PVector v;  // velocity
    PVector a;  // acceleration
    float m; // mass

    Ball(PVector pos, PVector v, PVector a, float m){
        this.pos = pos;
        this.v = v;
        this.a = a;
        this.m = m;
    }

    void update(){
        pos.add(v);
        v.add(a); 
    }

    void display(){
        noStroke();
        fill(0);
        ellipse(pos.x, pos.y, 10, 10);
    }

    void run (){
        update();
        display();
    }

    void setPos(PVector pos){
        this.pos = pos;
    }

    PVector getPos(){
        return pos;
    }

    void setV(PVector v){
        this.v = v;
    }

    PVector getV(){
        return v;
    }

    float getVMag(){
        return v.mag();
    }

    void setA(PVector a){
        this.a = a;
    }

    PVector getA(){
        return a;
    }

    float getAMag(){
        return a.mag();
    }

    void setMass(float m){
        this.m = m;
    }

    float getMass(){
        return m;
    }
}