// Date: 11-12-2022
// Demo Class 
// student Template

void setup() {
    
}

void draw() {
    
}

void drawBallsAroundCenter(float r, float t){
    ellipse(width/2+r*cos(radians(t)), height/2+r*sin(radians(t)), 5, 5);
}
