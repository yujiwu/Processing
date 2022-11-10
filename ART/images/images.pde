PImage img;

void setup() {
    size(540,540);
    //myBackground();
    img = loadImage("img1.jpg");
    imageMode(CENTER);
}

void draw() {
    drawImage(img);
    filter(GRAY);

}

void drawImage(PImage img){
    image(img, 270, 270, width, height);
    loadPixels();
    for(int i = 0; i < pixels.length; i++){
        float r = red(pixels[i]);
        float g = green(pixels[i]);
        float b = blue(pixels[i]);
        if (r < 50 && g < 50 && b <50){
            r = 255;
            g = 255;
            b = 255;
        }
        pixels[i] = color(r, g, b);
    }
    updatePixels();
}


void myBackground(){
    loadPixels();
    for (int i = 0; i < pixels.length; i++){
        //color(R,G,B)
        pixels[i] = color(random(10), random(10), random(255));
    }
    updatePixels();
}
