PImage img;
Ball ball; 
boolean pause = false;

void setup() {
    size(800,800);
     
    img = loadImage("bkg.png");
    imageMode(CENTER);

    PVector pos = new PVector(width/2,0);
    PVector v = new PVector(0,0);
    PVector a = new PVector(0,10);
    float m = 2;
    ball = new Ball(pos, v, a, m);
}

void draw() {
    // plot background image
    image(img, 400, 400, width, height);
    // plot velocity and accelertion of the ball
    fill(0);
    textSize(16);
    float mass = ball.getMass();
    float totEnergy = mass * ball.getAMag() * height;
    float ke = mass*ball.getAMag()*ball.getPos().y;
    float gpe = totEnergy - ke;
    text("mass: "+mass, 20, 20);
    text("velocity: "+ball.getVMag(), 20, 40);
    text("accelertion: "+ball.getAMag(), 20, 60);
    text("g.p.e.: "+gpe, 20, 80);
    text("k.e.: "+ke, 20, 100);
    // plot ball
    ball.run();
    if (ball.getPos().y > height - 30) noLoop();
    delay(1000);
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
