import processing.serial.*;

class CollectData {
    Serial dataPort;

    CollectData(String portName, PApplet parent){
        dataPort = new Serial(parent, portName, 9600);
    }

    Serial getDataPort(){
        return dataPort;
    }

    float getData() throws Exception{
        // reading data in datatype of String until 
        // hitting the change line delimiter'\n'
        String num = dataPort.readStringUntil(10);
        if (num == null) throw new Exception("No Data");
        return float(num);
    }

}