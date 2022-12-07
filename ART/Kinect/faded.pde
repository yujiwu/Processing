/*
    Author: Yujie Wu
    Date: 12/06/22
    This program generates an image by kinect raw depth data
    The image will be faded out if being further away from the infrared camera
*/

KinectCams cam;

void setup() {
    size(640, 480);
    // get an instance of KinectCams
    cam = new KinectCams(this);
    // initialize the depth camera
    cam.initDepthCam(false);
    noStroke();
}

void draw() {
    // array data stores the raw depth value the infrared depth camera sees
    int [] data = cam.getRawDepthData();
    // convert the value in data to the physical depth 

    highResolution(data);
}

void lowResolution(int [] data){
    int step = 20;
    
    for (int y = 0; y < height; y+=step) {
        for (int x = 0; x < width; x+=step) {    
            int index = x + y * width;
            float depthInMeter = depthConversion(data[index]);        
            if (depthInMeter > 1.5) 
                fill(#000000);
            else 
                fill(#EB82EC);
            rect(x, y, 20, 20);
        }
    }
    
}

void highResolution(int [] data){
    loadPixels();
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {    
            int index = x + y * width;
            float depthInMeter = depthConversion(data[index]);
            // if (depthInMeter < 1.3) pixels[index] = color(#ef71f0);
            // else if (depthInMeter < 1.4) pixels[index] = color(#d967da);
            // else if (depthInMeter < 1.5) pixels[index] = color(#c45cc4);
            // else if (depthInMeter < 1.6) pixels[index] = color(#ae52af);
            // else if (depthInMeter < 1.7) pixels[index] = color(#984899);
            // else if (depthInMeter < 1.8) pixels[index] = color(#823e83);
            // else if (depthInMeter < 1.9) pixels[index] = color(#6d336d);
            // else if (depthInMeter < 2.0) pixels[index] = color(#572957);
            // else if (depthInMeter < 2.1) pixels[index] = color(#411f41);
            // else if (depthInMeter < 2.2) pixels[index] = color(#2b152c);
            // else if (depthInMeter < 2.3) pixels[index] = color(#160a16);
            // else pixels[index] = color(#000000);

            if (depthInMeter < 0.5) pixels[index] = color(#ef71f0);
            else if (depthInMeter < 0.6) pixels[index] = color(#d967da);
            else if (depthInMeter < 0.7) pixels[index] = color(#c45cc4);
            else if (depthInMeter < 0.8) pixels[index] = color(#ae52af);
            else if (depthInMeter < 0.9) pixels[index] = color(#984899);
            else if (depthInMeter < 1.0) pixels[index] = color(#823e83);
            else if (depthInMeter < 1.1) pixels[index] = color(#6d336d);
            else if (depthInMeter < 1.2) pixels[index] = color(#572957);
            else if (depthInMeter < 1.3) pixels[index] = color(#411f41);
            else if (depthInMeter < 1.4) pixels[index] = color(#2b152c);
            else if (depthInMeter < 1.5) pixels[index] = color(#160a16);
            else pixels[index] = color(#000000);
        }
    }
    updatePixels();
}

float depthConversion(int rawDepth){
    if (rawDepth < 2047) return (float)(1.0 / ((double)(rawDepth) * -0.0030711016 + 3.3309495161));
    return 0.0f;
}

void printRawDepthData(int [] data){
    int step = 20;
    for (int y = 0; y < height; y+=step) {
        for (int x = 0; x < width; x+=step) {    
            int index = x + y * width;
            float depthInMeter = depthConversion(data[index]);
            if (x == width - 10) 
                println(depthInMeter);
            else {
                print(depthInMeter);
                print(" ");
            }
        }
    }
}