/*
    Author: Yujie Wu
    Date: 12/04/22
    This class contains the methods including show depth image, color image, and infrared image
    Your must init the specific kinect camera to show the image.
*/

import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;


public class KinectCams {
    

    Kinect kinect;

    //  @param _p parent sketch (usually "this")
    public KinectCams (PApplet _p) {
        kinect = new Kinect(_p);
    }
    
    public Kinect getKinect(){
        return kinect;
    }

    public void initDepthCam(boolean c){
        kinect.initDepth();
        if (c) kinect.enableColorDepth(true);
    }

    public PImage drawDepthImage(float x, float y){
        PImage img = kinect.getDepthImage();
        image(img, x, y);
        return img;
    }

    public PImage getDepthImage(){
        return kinect.getDepthImage();
    }

    public int [] getRawDepthData(){
        return kinect.getRawDepth();
    }

    // initialize Infra-red Camera or just init RGB Camera
    public void initInfraredCam(boolean ir){
        kinect.initVideo();
        if (ir) kinect.enableIR(true);
    }

    public PImage drawImage(float x, float y){
        PImage img = kinect.getVideoImage();
        image(img, x, y);
        return img;
    }

    public PImage getImage(){
        return kinect.getVideoImage();
    }

}
