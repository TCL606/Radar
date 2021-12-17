#include<SoftwareSerial.h>
#define delayTime 15
const int trig=3;
const int echo=8;
const int servo=9;
SoftwareSerial softSerial(7,6);//rx,tx

void setup()
{
  pinMode(trig,OUTPUT);
  pinMode(echo,INPUT);
  softSerial.begin(9600);
}

void loop()
{
  for(int i=6;i<175;i++) //不要转到0或180，否则会卡死。
 {                       //只在5-175之间转。
    spin(i);
    delay(delayTime);
    softSerial.print(i); 
    softSerial.print(","); 
    softSerial.print(Distance()); 
    softSerial.print("."); 
  }
  for(int i=175;i>=5;i--)
  {  
    spin(i);
    delay(delayTime);
    softSerial.print(i);
    softSerial.print(",");
    softSerial.print(Distance());
    softSerial.print(".");
  }
}

void spin(int angle) //50Hz pwm
{
  int pulse=(angle*11)+500;  
  digitalWrite(servo,HIGH);    
  delayMicroseconds(pulse);  
  digitalWrite(servo,LOW);     
  delayMicroseconds(20000-pulse);   
}  

int Distance()
{
  digitalWrite(trig,LOW);
  delayMicroseconds(8);
  digitalWrite(trig,HIGH);
  delayMicroseconds(10);
  digitalWrite(trig,LOW);
  return pulseIn(echo,HIGH)/58.00;
}
