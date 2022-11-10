float theta;
boolean pause = false;

void setup(){
    size(1280, 720);
    theta = 0;
}

void draw(){

    background(255);
    strokeWeight(2);
    stroke(0);
    // draw x-y coordinates
    drawArrow(50, height/2, 1200, 0);
    drawArrow(200, 600, 500, -90);
    drawArrow(400, 600, 500, -90);
    // draw circle
    noFill();
    drawCircle(200, height/2, 100);
    // draw a triangle in the circle
    drawTriangleSineWave(200, height/2, 100);
    theta -= 0.5;
}

// draw an arrow by taking parameters like start position (cy, cy), length, and the angle 
void drawArrow(int cx, int cy, int len, float angle){
  pushMatrix();
  translate(cx, cy);
  rotate(radians(angle));
  line(0,0,len, 0);
  line(len, 0, len - 8, -8);
  line(len, 0, len - 8, 8);
  popMatrix();
}

void  drawCircle(int cx, int cy, float radius){
  beginShape();
  for (float i = 0; i < 720; i += 0.5){
    float x = radius * cos(radians(i));
    float y = radius * sin(radians(i));
    vertex(x+cx, y+cy);
  }
  endShape(CLOSE);
}

void drawTriangleSineWave(int cx, int cy, float radius){
  // draw the hypotenuse side
  beginShape(LINES);
  float x = radius * cos(radians(theta));
  float y = radius * sin(radians(theta));
  vertex(x+cx, y+cy);
  vertex(cx, cy);
  endShape();
  // draw the opposite side
  beginShape(LINES);
  vertex(x+cx, y+cy);
  vertex(x+cx, cy);
  endShape();
  // draw the oppsite sides that consist of a sine wave 
  strokeWeight(0.1);
  for (float i = 0; i < -theta; i += 0.5){
    beginShape(LINES);
    vertex(50*radians(i)+cx+200, radius * sin(radians(-i))+cy);
    vertex(50*radians(i)+cx+200, cy);
    endShape();
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