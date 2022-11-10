void setup() {
    //size of the image returned by kinect V2 console
    size(512,424);
}

void draw() {
    
    
}

void example(){
    background(0);
    pushMatrix();
    rotate(radians(180));
    //translate(mouseX, mouseY);
    translate(width, height);
    text("haha", 10, 10);
    ellipse(0, 0, 20, 20);
    popMatrix();
}
