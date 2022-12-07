interface MovingObj{
    void setPos(PVector pos);
    PVector getPos();
    
    void setV(PVector v);
    PVector getV();
    float getVMag();
    
    void setA(PVector a);
    PVector getA();
    float getAMag();
    
    void setMass(float m);
    float getMass();
    
    void update();
    
    void display();
    
    void run();
}