// /*
//     Author: Yujie Wu
//     Date: 12/05/22
//     This program generates an image by kinect raw depth data
// */

// KinectCams cam;
// // list of color codes rendered for depth image
// int [] depthColors = {
//        #7fb4c9, #84b6c6, #88b8c4, #8dbbc1, #91bdbf, #96bfbc, #9ac1b9, #9fc4b7, 
//        #a3c6b4, #a8c8b2, #accaaf, #b1ccac, #b5cfaa, #bad1a7, #bed3a4, #c3d5a2, 
//        #c7d79f, #ccda9d, #d0dc9a, #d5de97, #d9e095, #dee392, #e2e590, #e7e78d
//     };
// NumToColor ntc;

// void setup() {
//     size(640, 480);
//     cam = new KinectCams(this);
//     cam.initDepthCam(false);
//     ntc = new NumToColor(2048, depthColors);
// }

// void draw() {
//     // For the kinect v1, the raw depth values range between 0 and 2048
//     // The bigger the value, the closer the pixel is
//     int [] rawDepthData = cam.getRawDepthData();
//     loadPixels();
//     for(int i = 0; i < pixels.length; i++){
//         pixels[i] = ntc.getColor(2048-rawDepthData[i]);
//     }
//     updatePixels();
// }
