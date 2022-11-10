/*
int thetaBlue;// initial value of theta for blue ball
int thetaRed; // initial value of theta for red ball
int radius; // initial value of radius
int d0; // rotate 10 degrees each time
int dr; //increase radius by 1 pixel each time
*/

int thetaBlue, thetaRed, radius, d0, dr; 
boolean pause;

void setup(){
    size(800, 600);
    background(#B79696);
    thetaBlue = 0; // initial value of theta for blue ball
    thetaRed = 180; // initial value of theta for red ball
    radius = 5; // initial value of radius
    d0 = 10; // rotate 10 degrees each time
    dr = 1; //increase radius by 1 pixel each time
    pause = false; // pause the animation
}

void draw(){
    noStroke();
    drawBalls();
}

void drawBalls(){
    // draw a blue ball
    fill(#B6DDFA);
    ellipse(width/2+radius*sin(radians(thetaBlue)), height/2+radius*cos(radians(thetaBlue)), 5, 5);
    // draw a red ball
    fill(#FAB6D0);
    ellipse(width/2+radius*sin(radians(thetaRed)), height/2+radius*cos(radians(thetaRed)), 5, 5);

    // update parameters for next round
    thetaBlue += d0;
    thetaRed += d0;
    radius += dr;
    if (radius > 400) {
        background(#B79696);
        thetaBlue = 0;
        thetaRed = 180;
        radius = 0;
    }
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
