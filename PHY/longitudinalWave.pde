/*
    Author: Yujie Wu
    Function: simulate the behavior of the particles in longitudinal wave
*/

int frequnecy = 10;
int amplitude = 50;
int theta = 0;
boolean pause = false;

void setup() {
    size(800,600);
    noStroke();
    fill(0);
}

void draw() {
    background(255);
    // no wave
    // for (int xPos = -amplitude; xPos < width + amplitude; xPos += 10){
    //     molecules(xPos);
    // }

    // longitudinal wave
    // for (int xPos = -amplitude; xPos < width + amplitude; xPos += 10){
    //     molecules(xPos + amplitude * sin(radians(xPos+theta)));
    // }
    theta -= 1;
}

void molecules(float xPos){
    for (int y = height / 2; y < 7 * height / 8; y += 4){
        ellipse(xPos + random(-5, 5), y, 2, 2);
    }
    for (int y = height / 2; y > height / 8; y -= 4){
        ellipse(xPos + random(-5, 5), y, 2, 2);
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


