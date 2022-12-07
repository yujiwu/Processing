int shift, dshift;
// pause: track if the animation is paused
// isOdd: track if the number of the layer is odd or even number
boolean pause, isOdd;
// angle to rotate the shape in starDynamic in Y-axis
int angle;

void setup() {
    size(600, 600, P3D);
    shift = 0; 
    dshift = 360; //increment for shift
    pause = false;
    isOdd = true;
    angle = 0;
}

// If rotateY() is called within the draw(), the transformation is reset when the loop begins again. 
void draw() {
    background(#d5f7f4);
    renderSunDynamics();
    //starStatic(300);
    
    //renderStarDynamic();
    
}

void starStatic(int size){
    float radius, x, y;
    stroke(#FF69B4);
    
    pushMatrix();
    beginShape();
    translate(width/2, height/2);
    for(int i = 0; i < 360; i++){
        radius = size * noise(i);
        x = radius * sin(radians(i));
        y = radius * cos(radians(i)); //radians(i) = TWO_PI/360 * i
        vertex(x, y);
    }
    endShape(CLOSE);
    popMatrix();
}

void starDynamic(int size){
    float radius, x, y;
    stroke(#FF69B4);
    
    beginShape();
    for(int i = 0; i < 360; i++){
        radius = size * noise(i+shift);
        x = radius * sin(radians(i));
        y = radius * cos(radians(i)); //radians(i) = TWO_PI/360 * i
        vertex(x, y);
    }
    endShape(CLOSE);
    shift += dshift;
    delay(200);
}

void renderStarDynamic(){
    translate(width/2, height/2);
    rotateY(radians(angle));
    starDynamic(300);
    angle += 5;
}


void sunStatic1(){
    float radius, x, y;
    stroke(#FF69B4);

    for(int i = 0; i < 360; i += 10){
        radius = 300 * noise(i);
        x = radius * sin(TWO_PI/360*i);
        y = radius * cos(TWO_PI/360*i);
        beginShape(LINES);
        vertex(width/2, height/2);
        vertex(x+width/2, y+height/2);
        endShape();
    }
}

void sunStatic2(){
    float radius, x, y;
    stroke(#FF69B4);

    for(int i = 0; i < 360; i += 10){
        radius = 300 * noise(i+shift);
        x = sin(TWO_PI/360*i);
        y = cos(TWO_PI/360*i);
        beginShape(LINES);
        vertex(15*x+width/2, 15*y+height/2);
        vertex(radius*x+width/2, radius*y+height/2);
        endShape();
    }
}

//outerSize: the radius of outer circle
//innerSize: the radius of outer circle
//theta: the start position to draw the circle (value in degree)
//rotate: the step to draw the next line in the circle (value in degree)
void sunDynamic(int outerSize, int innerSize, int theta, int rotate){
    float radius, x, y;
    // give the thinkness the broader 
    strokeWeight(2);
    stroke(noise(frameCount)*255, noise(frameCount+5)*255, noise(frameCount+10)*255);
    for(int i = theta; i < 360; i += rotate){
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

void renderSunDynamics(){
    pushMatrix();
    translate(width/2, height/2);
    for (int i = 10; i < 300-90; i += 50){
        if (isOdd){
            sunDynamic(i+90, i, 0, 10);
            isOdd = false;
        }else{
            sunDynamic(i+90, i, 5, 10);
            isOdd = true;
        }
    }
    popMatrix();
    delay(100);
}

void mouseClicked(){
    if (pause){
        loop();
        pause = false;
    }else{
        noLoop();
        pause = true;
    }
}