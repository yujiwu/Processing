/*
    Date : 11/12/2022
    Job done by Jelley 梁嘉麟 
*/
float radius = 5;
float theta = 0;
void setup(){
    size(800, 600);
    background(#B79696);
    noStroke();
}

void draw(){
    fill(#4851F5);
    drawBallsAroundCenter(radius, theta+45);
     fill(#F75545);
    drawBallsAroundCenter(radius, theta+135);
     fill(#15F545);
    drawBallsAroundCenter(radius, theta+90);
     fill(#7F5545);
    drawBallsAroundCenter(radius, theta+180);
     fill(#FFFFFF);
    drawBallsAroundCenter(radius, theta+225);
     fill(#00ECFF);
    drawBallsAroundCenter(radius, theta+270);
     fill(#00FF79);
    drawBallsAroundCenter(radius, theta+315);
        fill(#F200FF);
    drawBallsAroundCenter(radius, theta+360);
       radius = radius + 1;
    theta = theta + 7;
}

void drawBallsAroundCenter(float r, float t){
    ellipse(width/2+r*cos(radians(t)), height/2+r*sin(radians(t)), 5, 5);
}