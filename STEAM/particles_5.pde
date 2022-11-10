//任务5
//试试你能否画出红色的小球
float radius = 20;
float theta = 0;

void setup(){
    size(800, 600);
    background(#B79696);
    noStroke();
}

void draw(){
    // draw blue balls
    fill(#4851F5);
    drawBallsAroundCenter(radius, theta);
    // draw red balls
    fill(#F75555);
    drawBallsAroundCenter(radius, theta+180);
    radius = radius + 1;
    theta = theta + 10;
}

void drawBallsAroundCenter(float r, float t){
    ellipse(width/2+r*cos(radians(t)), height/2+r*sin(radians(t)), 5, 5);
}