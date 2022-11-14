//任务4
float radius = 20;
float theta = 0;

void setup(){
    size(800, 600);
    background(#B79696);
    noStroke();
}

void draw(){
    fill(#4851F5);
    drawBallsAroundCenter(radius, theta);
    //知识点：count 计算机中变量递增的概念
    radius = radius + 1;
    theta = theta + 10;
}

void drawBallsAroundCenter(float r, float t){
    ellipse(width/2+r*cos(radians(t)), height/2+r*sin(radians(t)), 5, 5);
}