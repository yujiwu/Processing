class Ball{
    PVector pos; // position
    PVector v;  // velocity
    PVector a;  // acceleration

    Ball(PVector pos, PVector v, PVector a){
        this.pos = pos;
        this.v = v;
        this.a = a;
    }

    void update(PVector acceleration){
        pos.add(v);
        v.add(a);
        a = acceleration;
    }

    void display(){
        noStroke();
        fill(0);
        ellipse(pos.x, pos.y, 10, 10);
    }

    void run (PVector acceleration){
        update(acceleration);
        display();
    }
}