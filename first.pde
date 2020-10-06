//piano
ArrayList<Piano> pianos =new ArrayList<Piano>();
Piano piano;
boolean if_piano=false;

void setup()
{
  size(displayWidth,displayHeight);
  //frameRate(30);

}

void draw()
{
  background(0);
  if(if_piano){
    for(int i=0;i<pianos.size();i++){
      pianos.get(i).display();
    }
  }
}

void keyPressed(){
  if(key=='1'){
    if_piano=true;
    piano=new Piano(1);
    pianos.add(piano);
  }
  else if(key=='2'){
    if_piano=true;
    piano=new Piano(2);
    pianos.add(piano);
  }
  else if(key=='3'){
    if_piano=true;
    piano=new Piano(3);
    pianos.add(piano);
  }
  else if(key=='4'){
    if_piano=true;
    piano=new Piano(4);
    pianos.add(piano);
  }
  else if(key=='5'){
    if_piano=true;
    piano=new Piano(5);
    pianos.add(piano);
  }
  else if(key=='6'){
    if_piano=true;
    piano=new Piano(6);
    pianos.add(piano);
  }
  else if(key=='7'){
    if_piano=true;
    piano=new Piano(7);
    pianos.add(piano);
  }
  else if(key=='8'){
    if_piano=true;
    piano=new Piano(8);
    pianos.add(piano);
  }
}


class Piano{
  color a=color(random(250,255),random(0,144),random(0,250));
  color b=color(random(38,80),random(40,145),random(180,255));
  color c=color(random(190,230),random(230,255),random(50,70));
  color d=color(random(180,220),random(100,160),random(210,255));
  color e=color(random(150,180),random(210,255),random(100,130));
  color f=color(random(170,240),random(120,160),random(0,40));
  color g=color(random(230,255),random(80,160),random(140,200));
  color h=color(random(70,180),random(150,190),random(210,255));
  color color_set;
  float glavity,speed,xpos,ypos;
  float radius=random(50,100);
  Piano(int key_piano){
    glavity=1;
    speed=0;
    ypos=0;
    xpos=key_piano*displayWidth/9;
    if(key_piano==1)
      color_set=a;
    else if(key_piano==2)color_set=b;
    else if(key_piano==3)color_set=c;
    else if(key_piano==4)color_set=d;
    else if(key_piano==5)color_set=e;
    else if(key_piano==6)color_set=f;
    else if(key_piano==7)color_set=g;
    else color_set=h;   
  }
  
  void display(){
    noStroke();
    fill(color_set);
    ellipse(xpos,ypos,radius,radius);
    speed+=glavity;
    ypos+=speed;
    if(ypos>=displayHeight-50){
      if(abs(speed)<=1){
        speed=0;glavity=0;
      }
      speed*=-0.8;
    }
  }
  
}
