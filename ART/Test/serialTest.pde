//import processing.serial.*;

//Serial dataPort;

//void setup() {
//    // print all the port names to identify which one we use
//    //printArray(Serial.list());
//    String portName = Serial.list()[2];
//    dataPort = new Serial(this, portName, 9600);
//}

//void draw() {
//    while(dataPort.available() > 0){
//        // integer 10 is the new line character in ASCII
//        String info = dataPort.readStringUntil(10);
//        if (info != null){
//            println(info);
//        }
//    }
//}
