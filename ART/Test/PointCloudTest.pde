int angle = 0; 
PImage img;
boolean pause = false;

void setup() {
    size(738, 864, P3D);
    img = loadImage("Musk.png");
    noStroke();
    fill(110,60,200);
}

void draw() {
    //pointCloud();
    portrait();
    //depthPointCloud();
}

void portrait(){
    background(255);
    pushMatrix();
    translate(width/2, 0, 0);
    int step = 5;
    for (int y = 0; y < height; y+=step) {
        for (int x = - width/2; x < width/2; x+=step) {
            int offset = x + width/2 + y * width;
            float z = brightness(img.pixels[offset]);
            if (z != 0){
                float size = 5 - 5 * z / 255;
                rotateY(radians(angle));
                ellipse(x, y, size, size);
            }
            
        }
    }
    popMatrix();
    angle += 1;
}

void pointCloud(){
    background(255);
    pushMatrix();
    translate(width/2, 0, 0);
    int step = 5;
    for (int y = 0; y < height; y+=step) {
        for (int x = - width/2; x < width/2; x+=step) {
            int offset = x + width/2 + y * width;
            float z = brightness(img.pixels[offset]);
            if (z != 0){
                float size = 5 - 5 * z / 255;
                
                ellipse(x, y, size, size);
            }
            
        }
    }
    popMatrix();
    angle += 1;
}

void depthPointCloud(){
    background(255);
    pushMatrix();
    translate(width/2, 0, 0);
    beginShape(POINTS);
    int step = 5;
    for (int y = 0; y < height; y+=step) {
        for (int x = - width/2; x < width/2; x+=step) {
            int offset = x + width/2 + y * width;
            float z = brightness(img.pixels[offset]);  
            vertex(x, y, -z);
        }
    }
    rotateY(radians(angle));
    endShape();
    popMatrix();
    angle += 1;
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
