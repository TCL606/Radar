import processing.serial.*;

Serial screen;
int angle=0,dist=999;

void setup()
{
  size(1800,1000);
  smooth();
  screen=new Serial(this,"COM3",9600);
  screen.bufferUntil('.');
  frameRate(50);
}

void draw()
{
  Framework();
  Scan();
}

void Scan()
{
  float fragment=0;
  pushMatrix();
  fill(0,0,0);
  noStroke();
  rect(0, height*0.937, width,0.1*height);//add a rectangle to prevent text blurring
  translate(0.05*width,0.9*height);       //the color should be used as (r,g,b)
  fill(#4DD38C);
  textSize(35);
  text("Object:",0.08*width,0.075*height);
  text("Angle:",0.37*width,0.075*height);
  text("Distance:",0.62*width,0.075*height);
  resetMatrix();
  translate(0.5*width,0.9*height);
  strokeWeight(15);
  if(dist<200)
  {
    fragment=map(dist,0,200,0,0.45*width);
    stroke(150,200,100);
    line(0,0,fragment*cos(-radians(angle)),fragment*sin(-radians(angle)));
    stroke(255,55,25);
    line(fragment*cos(-radians(angle)),fragment*sin(-radians(angle)),0.45*width*cos(-radians(angle)),0.45*width*sin(-radians(angle)));
    resetMatrix();
    translate(0.05*width,0.9*height);
    fill(#CE2136);
    text("In range",0.15*width,0.075*height);
    text(angle+" °",0.43*width,0.075*height);
    text(dist+"  cm",0.71*width,0.075*height);
  }
  else
  {
   stroke(150,200,100);
   line(0,0,0.45*width*cos(-radians(angle)),0.45*width*sin(-radians(angle)));
   resetMatrix();
   translate(0.05*width,0.9*height);
   text("Out of range",0.15*width,0.075*height);
   text(angle+" °",0.43*width,0.075*height);
   text("Failed to detect",0.71*width,0.075*height);
  }
  popMatrix();
}

void Framework()
{
  pushMatrix();
  noStroke();
  fill(0,4); 
  rect(0, 0, width, height); //add a rectangle to add shadow
  translate(0.05*width,0.9*height); //the color should be filled 2 parameters
  noFill();
  strokeWeight(2);
  stroke(220,200,100);
  line(0,0,0.9*width,0);
  resetMatrix();
  translate(0.5*width,0.9*height);
  arc(0,0,0.225*width,0.225*width,PI,TWO_PI);
  arc(0,0,0.455*width,0.455*width,PI,TWO_PI);
  arc(0,0,0.675*width,0.675*width,PI,TWO_PI);
  arc(0,0,0.9*width,0.9*width,PI,TWO_PI);
  line(0,0,0.45*width*cos(radians(-30)),0.45*width*sin(radians(-30)));
  line(0,0,0.45*width*cos(radians(-60)),0.45*width*sin(radians(-60)));
  line(0,0,0.45*width*cos(radians(-90)),0.45*width*sin(radians(-90)));
  line(0,0,0.45*width*cos(radians(-120)),0.45*width*sin(radians(-120)));
  line(0,0,0.45*width*cos(radians(-150)),0.45*width*sin(radians(-150)));
  textSize(30);
  fill(#DFE59B);
  text(" 30°",0.45*width*cos(radians(-30)),0.45*width*sin(radians(-30)));
  text("60°",0.449*width*cos(radians(-60)),0.452*width*sin(radians(-60)));
  text("90°",-0.01*width,0.452*width*sin(radians(-90)));
  text("120°",0.48*width*cos(radians(-120)),0.456*width*sin(radians(-120)));
  text("150°",0.48*width*cos(radians(-150)),0.452*width*sin(radians(-150)));
  resetMatrix();
  translate(0.485*width,0.9*height);
  text("0",0.011*width,0.03*height);
  text("50cm",0.1125*width,0.03*height);
  text("50cm",-0.1125*width,0.03*height);
  text("100cm",2*0.1125*width,0.03*height);
  text("100cm",-2*0.1125*width,0.03*height);
  text("150cm",3*0.1125*width,0.03*height);
  text("150cm",-3*0.1125*width,0.03*height);
  text("200cm",4*0.1125*width,0.03*height);
  text("200cm",-4*0.1125*width,0.03*height);
  popMatrix();
}

void serialEvent(Serial screen)
{
 String data=screen.readStringUntil('.');
 data=data.substring(0,data.length()-1);
 angle=int(data.substring(0,data.indexOf(',')));
 dist=int(data.substring(data.indexOf(',')+1,data.length()));
}
