
int x = 20;
int dx = 3;
float amplitude = 50;
float wavelength = 2 * TWO_PI;
long start, end;
ArrayList<PVector> dots;
boolean pause = false;

void setup() {
    size(1400, 700);
    noStroke();
    fill(0);
    textSize(16);
    dots = new ArrayList<PVector>();
    start = System.currentTimeMillis();
}

void draw() {
    background(255);
    waveCalculation(x, height / 2, amplitude, wavelength);
    waveRender();
    x += dx;
    if (x > width - 20){
        noLoop();
    }
    end = System.currentTimeMillis();
    long time = (end - start)/1000;
    text("Time: "+time+" s", 20, 20);
}

void waveRender(){
    for (PVector dot: dots){
        ellipse(dot.x, dot.y, 2, 2);
    }
}

void waveCalculation (int xPos, float yPos, float amplitude, float wavelength){
    yPos = sin((TWO_PI / wavelength) * radians(-xPos)) * amplitude + yPos;
    dots.add(new PVector(xPos, yPos));
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