/*
    Author: Yujie Wu (UG)
    This program simulates the behavior of each molecule in a ripple. 
*/ 

// Color Series: #F50000 #F5A400 #CB00F5 #00A9F5 #0022F5 (red to blue)
int waveSpeed = 100;
float diagonal; // diagonal of the canvas
float[] xPos, yPos; // arrays to store the x-y coordinate of each dot
//int[] colorSeries = {#CB00F5, #F5A400, #F50000, #F5A400, #CB00F5, #00A9F5, #0022F5, #00A9F5};
int[] colorSeries = {#3A6489, #5996C9, #74BFFF, #5996C9, #3A6489, #1E3548, #030608, #1E3548};
boolean pause = false;

void setup(){
    size(800,600);
    diagonal = sqrt(pow(width, 2) + pow(height, 2));
    xPos = new float[int((diagonal/2-20)*18/10)];
    yPos = new float[int((diagonal/2-20)*18/10)];
}

void draw(){
    background(#088AFA);
    noStroke();
    molecule();
    renderMolecule();
    colorSeries();
    delay(waveSpeed);
}

void molecule(){
    // angle theta in x-y plane 
    float theta;
    
    for(int radius = 20; radius < diagonal/2; radius += 10){
        theta = 0;
        for(int i = 0; i < 18; i++){
            xPos[i+(radius-20)*18/10] = radius*sin(theta)+width/2;
            yPos[i+(radius-20)*18/10] = radius*cos(theta)+height/2;
            theta += TWO_PI/18;
        }
    }
}

void renderMolecule(){
    for(int i = 0; i < xPos.length; i++){
        fill(colorSeries[(int(i/18)%8)]);
        ellipse(xPos[i], yPos[i],5,5);
    }
}

void colorSeries(){
    colorSeries = splice(colorSeries, colorSeries[colorSeries.length-1], 0);
    colorSeries = shorten(colorSeries);
}

void mouseClicked() {
  if (pause){
    loop();
    pause = false;
  }else {
    noLoop();
    pause = true;
  }
}