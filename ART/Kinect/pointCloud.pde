KinectCams cam; 
// degrees to rotate
int angle = 0;
// how big to magnify the z distance
int magnify = 100;
boolean pause = false;
int [] random;

void setup() {
    size(640, 480, P3D);
    cam = new KinectCams(this);
    cam.initDepthCam(false);
    random = new int[height*width];
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            int offset = x + y * width;
            random[offset] = int(random(0, 300));
        } 
    }  
}

void draw() {
    //pointCloud2D();
    //rectCloud2D();
    pointCloud3D();
}

void pointCloud2D(){
    background(255);
    int [] rawDepthData = cam.getRawDepthData();
    beginShape(POINTS);
    int step = 5;
    for (int y = 0; y < height; y+=step) {
        for (int x = 0; x < width; x+=step) {
            int offset = x + y * width;
            float z = magnify*physicalDepthConversion(rawDepthData[offset]);  
            if (z < 100){
                vertex(x, y);
            }
            
        }
    }
    endShape();
}

void rectCloud2D(){
    background(255);
    fill(0);
    noStroke();
    int [] rawDepthData = cam.getRawDepthData();
    int step = 5;
    for (int y = 0; y < height; y+=step) {
        for (int x = 0; x < width; x+=step) {
            int offset = x + y * width;
            float size = physicalDepthConversion(rawDepthData[offset]);  
            if (size < 2){
                size = 4 - size;
                rect(x, y, size, size);
            }
        }
    }
}

void pointCloud3D(){
     background(255);
    int [] rawDepthData = cam.getRawDepthData();
    pushMatrix();
    translate(width/2, 0, 0);
    beginShape(POINTS);
    int step = 5;
    for (int y = 0; y < height; y+=step) {
        for (int x = - width/2; x < width/2; x+=step) {
            int offset = x + width/2 + y * width;
            // get the z-coordinate
            float z = magnify*physicalDepthConversion(rawDepthData[offset]);  
            // filter out the points which are too far from the kinect camera
            if (z <= 100) {
                z += random[offset];
                vertex(x, y, -z);
            }
        }
    }
    rotateY(radians(angle));
    endShape();
    popMatrix();

    angle++;
}

float physicalDepthConversion(int rawDepth){
    if (rawDepth < 2047) return (float)(1.0 / ((double)(rawDepth) * -0.0030711016 + 3.3309495161));
    return 0.0f;
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
