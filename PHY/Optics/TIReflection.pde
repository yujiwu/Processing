float incidentAngle, reflectedAngle, refractedAngle;
// reflective index
float n;

void setup() {
    size(800,600);
    n = 1.6;
}

void draw() {
    background(255);
    fill(#d5f7f4);
    semiCircularGlass(200);

    //calculate angles in radians
    incidentAngle = asin((mouseX - width / 2) / dist(mouseX, mouseY, width/2, height/3));
    reflectedAngle = incidentAngle;
    refractedAngle = asin(sin(incidentAngle) * n);

    fill(0);
    textSize(16);
    text("Incident Angle: "+incidentAngle*180/PI, 20, 20);
    text("Refracted Angle: "+refractedAngle*180/PI, 20, 40);
    text("Reflected Angle: "+reflectedAngle*180/PI, 20, 60);
    
    //plot incident ray
    line(mouseX, mouseY, width/2, height/3);
    //plot refracted ray
    line(width/2, height/3, width/2 - sin(refractedAngle) * 200, height/3 - cos(refractedAngle) * 200);
    
    if (Float.isNaN(refractedAngle)){
        //plot reflected ray
        line(width/2, height/3, width/2 - sin(reflectedAngle) * 200, height/3 + cos(reflectedAngle) * 200);
    }
    
}

void semiCircularGlass(float radius){
    beginShape();
        for (float i = 0; i <= 180; i += 2){
            float x = radius * cos(radians(i));
            float y = radius * sin(radians(i));
            vertex(x+width/2, y+height/3);
        }
    endShape(CLOSE);
}

