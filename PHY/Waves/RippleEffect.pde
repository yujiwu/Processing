float [][] previous, current;
float dampening = 0;

void setup() {
    size(800, 800);
    previous = new float[width][height];
    current = new float[width][height];
    // dampening ranging from 0 to 1
    dampening  = 0.99;
}

void draw() {
    background(0);
    loadPixels();
    for (int x = 1; x < width - 1; x++){
        for (int y = 1; y < height - 1; y++){
            // calculate the height of the current wave
            current[x][y] = (previous[x-1][y] + previous[x+1][y] 
                            + previous[x][y-1] + previous[x][y+1]) / 2 - current[x][y];
            current[x][y] = current[x][y] * dampening;
            // render pixels
            pixels[x + y * width] = color(current[x][y]*255);
        }
    }

    updatePixels();

    // swap states of waves
    float [][] temp = current;
    current = previous;
    previous = temp;
}

void mouseClicked() {
    if (mouseX > 0 && mouseY > 0 && mouseX < width && mouseY < height){
        current[mouseX][mouseY] = 255;
    }
}
