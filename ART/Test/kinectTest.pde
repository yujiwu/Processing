//import org.openkinect.freenect.*;
//import org.openkinect.freenect2.*;
//import org.openkinect.processing.*;
//import org.openkinect.tests.*;

//Kinect kinect;

//void setup() {
//    size(480,360);
//    // size for the color camera of kinect version 1 
//    //size(640, 480);
//    // size for the depth camera of kinect version 1 
//    //size(320, 240);
//    // size for the color camera of kinect version 2
//    //size(1920, 1080);
//    // size for the depth camera of kinect version 2
//    //size(512, 424);

//    // initialize a camera of kinect
//    //initDepthCam();
//    initInfraredCam(true);
    
//}

//void draw() {
//    //drawDepthImage();
//    drawImage();
//}

//void initDepthCam(){
//    kinect = new Kinect(this);
//    kinect.initDepth();
//}

//PImage drawDepthImage(){
//    PImage img = kinect.getDepthImage();
//    image(img, 0, 0);
//    return img;
//}

//// initialize Infra-red Camera or just init RGB Camera
//void initInfraredCam(boolean ir){
//    kinect = new Kinect(this);
//    kinect.initVideo();
//    if (ir) kinect.enableIR(true);
//}

//PImage drawImage(){
//    PImage img = kinect.getVideoImage();
//    image(img, 0, 0);
//    return img;
//}
