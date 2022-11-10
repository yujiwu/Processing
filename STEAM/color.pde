int red = 240;
int green = 215;
int blue = 225;
int x = 30;
int y = 30;

void setup(){
    size(800, 600);
    background(255);
}

void draw(){
    noStroke();
    // fill(Red, green, blue)
    fill(red,green,blue);
    green -= 1;
    blue -= 1;
    
    ellipse(x,y,30,30);
    x += 50;
    if (x > 740){
        x = 30;
        y += 50;
    }
    
    if (y > 540){
        x = 30;
        y = 30;
        green = 215;
        blue = 225;
    }
    delay(100);
}