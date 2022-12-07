import processing.serial.*;

int x = 0;
int dx = 1;
// float wavelength [] = {0.5 * TWO_PI, 1 * TWO_PI, 0.666 * TWO_PI, 0.1 * TWO_PI, 3 * TWO_PI};
// float amplitude [] = {50, 30, 60, 40, 10};
// float shift [] = {0,0,0,0,0};
//used to store the single sine waves
ArrayList<Wave> waveList1;
// serial port from which we can collect various data
Serial dataPort;

// list of color codes rendered under the waves
int [] shadowColors = {
        #7fb4c9, #88b8c9, #92bdc8, #9bc1c8, 
        #a4c5c8, #adcac8, #b7cec7, #c0d3c7,
        #c9d7c7, #d2dbc7, #dce0c6, #e5e4c6
    };

void setup() {
    size(1400, 700, P3D);
    noStroke();
    background(0);
    // get the instance of wave list
    waveList1 = new ArrayList<Wave>();
    // setup the serial post
    String portName = Serial.list()[2];
    dataPort = new Serial(this, portName, 9600);
    
    // get Data from sensor
    for (int i = 0; i < 5; i++) {
        try {
            //float wavelength = getData() / 100 * TWO_PI;
            float amplitude = getData();
            //float shift = getData();
            println(amplitude);
            float wavelength = random(0.2, 3) * TWO_PI;
            //float amplitude = random(10, 70);
            float shift = random(0, 90);
            waveList1.add(new Wave(wavelength, amplitude, shift));
        } catch (Exception e) {
            //println(e.getMessage());
            i--;
        }
    }
}

void draw() {

    // calculate the value of y
    float y = height / 3;
    Waves ws = new Waves(waveList1);
    // render a combination of simple wave: render(int c, float x, float y, float size)
    y = ws.update(x, y);
    for (int i = 3; i <= 10; i++) {
        y += fib(i);
        ws.render(#1EB9F5, x, y, 3);
    }

    // render the shadow of the wave
    // get the length of the shadow
    float len = 230*noise(x);
    //get an instance of color
    NumToColor ntc = new NumToColor(len, shadowColors);
    if (x % 6 == 0){
        for (int i = 0; i < len; i++) {
            fill(ntc.getColor(i));
            ellipse(x, y + linear(i), 2, 2);
        }
    }else if (x % 6 == 3){
        for (int i = 0; i < 24; i++) {
            fill(ntc.getColor(i));
            ellipse(x, y + linear(i), 1, 1);
        }
    } 
    // go to next column 
    x += dx;

    // stops if wave reach the right side of the canvas
    if (x > width){
        noLoop();
    }
}

float getData() throws Exception{
    String num = dataPort.readStringUntil(10);
    if (num == null) throw new Exception("No Data");;
    if (float(num) < 0) throw new Exception("Out of Measuring Range");
    return float(num);
}
