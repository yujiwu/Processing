import processing.sound.*;

// make a dynamic color ring
int shift, dshift;
// pause: track if the animation is paused
boolean pause;
// angle to rotate the shape in starDynamic in Y-axis
int angle;
//color series in hex number for each layer 
color [] layer1 = {#FCF003, #F7E223, #F79E4A};
color [] layer2 = {#f7dad5, #f7b4a8, #f081d8, #f081c2};
color [] layer3 = {#f05d96, #f03a61, #b315a3, #94094e, #94092c, #820524};
SoundFile bgm;

void setup() {
    // width and height must be greater than 50 pixels
    size(600, 600, P3D);
    shift = 0; 
    dshift = 360; //increment for shift
    pause = false;
    angle = 0;
    // bgm = new SoundFile(this, "Ellipse.wav");
    // bgm.loop();
}

// If rotateY() is called within the draw(), the transformation is reset when the loop begins again. 
void draw() {
    background(#191a19);
    renderColoringDynamic();
    delay(150);
}

//outerSize: the radius of outer circle
//innerSize: the radius of outer circle
//theta: the start position to draw the circle (value in degree)
//rotate: the step to draw the next line in the circle (value in degree)
//c: define the color
void coloringDynamic(int outerSize, int innerSize, float theta, int rotate, color c){
    float radius, x, y;
    // give the thinkness the broader 
    strokeWeight(2);
    stroke(c);
    for(float i = theta; i < 360; i += rotate){
        radius = outerSize * noise(i+shift)+innerSize;
        x = sin(radians(i));
        y = cos(radians(i));
        beginShape(LINES);     
        vertex(innerSize*x, innerSize*y);
        vertex(radius*x, radius*y);
        endShape();
    }
    shift += dshift;
}

void renderColoringDynamic(){
    pushMatrix();
    translate(width/2, height/2);
    float radius = min(width/2, height/2);
    int step = int((radius - 10) / 4); 
    for (int i = 1; i < 4; i++){
        // first layer
        if (i == 1){
            coloringDynamic(10+2*step, 10, 0, 5, layer1[frameCount%layer1.length]);
         
        // second layer
        }else if (i == 2) {
            coloringDynamic(10+3*step, 10+step, 2.5, 5, layer2[frameCount%layer2.length]);
    
        // third layer
        }else{
            coloringDynamic(10+4*step, 10+2*step, 0, 5, layer3[frameCount%layer3.length]);
        }
    }
    popMatrix();
}

void mouseClicked(){
    if (pause){
        //bgm.play();
        loop();
        pause = false;
    }else{
        //bgm.pause();
        noLoop();
        pause = true;
    }
}
