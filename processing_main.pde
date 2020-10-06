//data setting
int light_start_speed=4;
//change bgc (Q/A)
int x,w=8;
float color_bgc,color_set=162;
boolean if_turn_bgc=false;
//newLife//
//generate light(W/S/X)
boolean if_turn_life_on=false;
ArrayList<newLife> lights = new ArrayList<newLife>();
newLife light;
int cur_light=-1,count=light_start_speed;
//particles
ArrayList particles = new ArrayList();
float area = 0;
boolean if_particles=false;
//paralysis state//
boolean if_paralysis=false;
//Circle
ArrayList<Circle> circles = new ArrayList<Circle>();
Circle circle;
int num_circle=45;
//rect
float strokeWeight=7;
ArrayList<rect_left> r_lefts = new ArrayList<rect_left>();
ArrayList<rect_right> r_rights = new ArrayList<rect_right>();
int num_rect=40;
rect_left r_left;
rect_right r_right;
float rect_speed=0.05;
float minux=0.01;

void setup(){
  size(displayWidth, displayHeight);
  smooth();
  for(int i=0;i<num_circle;i++){
    circle = new Circle(i*50);
    circles.add(circle);
  }
  for(int i=0;i<num_rect;i++){
    float y=sqrt(sq(displayWidth)+sq(displayHeight));
    r_left=new rect_left(50*i,50*i+y);
    r_lefts.add(r_left);
  }
  for(int i=0;i<num_rect;i++){
    float y=sqrt(sq(displayWidth)+sq(displayHeight));
    r_right=new rect_right(50*i,50*i+y);
    r_rights.add(r_right);
  }
  for (int i = 0; i < 540; i+=30) {
    particles.add(new Particle(i));
  }
}

void draw(){
  background(color_set);

  if(if_particles==true){
     for (int i = 0; i < particles.size(); i++) {
      Particle p = (Particle) particles.get(i);
      p.move();
      p.draw();
      p.boundary();
    }
  }
  if(if_turn_life_on==true){
    for(int i=0;i<lights.size();i++){
      lights.get(i).run();
      lights.get(i).display();
    }
  }
  if(if_paralysis==true){
    color_set=255;
    for(int i=0;i<num_circle;i++){
      circles.get(i).run();
      circles.get(i).display();
    }
    for(int i=0;i<num_rect;i++){
      r_lefts.get(i).run();
      r_lefts.get(i).display();
    }
    for(int i=0;i<num_rect;i++){
      r_rights.get(i).run();
      r_rights.get(i).display();
    }
  }
  if(if_turn_bgc==true){
    turn_bgc(color_bgc);
  }
}
    
void keyPressed(){
  if((key=='Q')||(key=='q')){
    if_turn_bgc=true;
    color_bgc=0;
    x=displayWidth;
  } 
  else if((key=='A')||(key=='a')){
    if_turn_bgc=true;
    color_bgc=162;
    x=displayWidth;
  }
  else if((key=='Z')||(key=='z')){
    if_turn_bgc=true;
    color_bgc=255;
    x=displayWidth;
  }
  else if((key=='W')||(key=='w')){
    if_turn_life_on=true;
    light = new newLife(count);
    lights.add(light);
    count+=1;
    cur_light+=1;
  }
  else if((key=='S')||(key=='s')){
    lights.get(cur_light).if_turn_life_off=true;
  }
  else if((key=='X')||(key=='x')){
    reset_light();
  }
  else if((key=='E')||(key=='e')){
    color_set=0;
    if_paralysis=false;

  }
  else if((key=='D')||(key=='d')){
    color_set=255;
    if_paralysis=false;
  }
  else if((key=='C')||(key=='c')){
    if_paralysis=true;
    if_particles=false;
  }
  else if((key=='F')||(key=='f')){
    if_particles=true;
  }
  else if((key=='R')||(key=='r')){
    if_turn_bgc=false;
    if_turn_life_on=false;
    if_particles=false;
    if_paralysis=false;
  }
  else if((key=='V')||(key=='v')){
    if_particles=false;
  }
}   
    
void turn_bgc(float color_bgc){
    noStroke();
    fill(color_bgc);
    rect(x,0,w+=8,displayHeight);
    x-=8;
    if(x<0){
      if_turn_bgc=false;
      color_set=color_bgc;
    }
}

void reset_light(){
  lights = new ArrayList<newLife>();
  if_turn_life_on=false;
  cur_light=-1;
  count=light_start_speed;
}

class newLife{
  boolean if_change_color=true;
  int transparency=255;
  float speed;
  float xpos=displayWidth;
  float w=displayWidth;
  boolean if_turn_life_off=false;
  newLife(float count){
    speed=count;
    if(speed>=15) speed=15;
  }
  void display(){
    noStroke();
    fill(255,235);
    rect(xpos,0,w,displayHeight);
    if((xpos<displayWidth/2)&&(if_change_color)){
      float r,g,b;
      r=random(100,255);
      g=random(100,255);
      b=random(100,255);
      for (int i = 0; i < particles.size(); i++) {
      Particle p = (Particle) particles.get(i);
      p.change_color(r,g,b);
      if_change_color=false;
      }
    }
  };
  void run(){
    xpos-=speed;
    if(if_turn_life_off==true){
      w=displayWidth-xpos;
      if_turn_life_off=false;
    }
  }
  
}

class Circle{
  float r;
  Circle(float radius){
    r=radius;
  }
  void run(){
    r+=1;
    if(r>sqrt(sq(displayWidth)+sq(displayHeight))) r=1;
  }
  void display(){
    ellipseMode(CENTER);
    stroke(0);
    noFill();
    strokeWeight(strokeWeight);
    ellipse(displayWidth/2,displayHeight/2,r,r);
  }
}

class rect_left{
  float angle=0;
  float def_y;
  float x,y;
  rect_left(float xx,float yy){
    x=xx;
    def_y=yy;
    y=yy;
  }
  void display(){
    rectMode(CENTER);
    stroke(0);
    noFill();
    strokeWeight(strokeWeight);
    rect(-10,-10,x,y,x);
    rotate(angle);
    translate(-displayWidth/2,-displayHeight/2);
    angle+=rect_speed;
  }
  void run(){
    translate(displayWidth/2,displayHeight/2);
    rotate(-angle);
    y=def_y*abs(sin(angle))+x;
  }
}
class rect_right{
  float angle=0;
  float x,y;
  float def_y;
  rect_right(float xx,float yy){
    x=xx;
    y=yy;
    def_y=yy;
  }
  void display(){
    rectMode(CENTER);
    stroke(0);
    noFill();
    strokeWeight(strokeWeight);
    rect(10,10,x,y,x);
    rotate(-angle);
    translate(-displayWidth/2,-displayHeight/2);
    angle+=rect_speed; 
  }
  void run(){
    translate(displayWidth/2,displayHeight/2);
    rotate(angle);
    y=def_y*abs(sin(angle))+x;
  }
}

class Particle {
  PVector loc, vel;
  float r=235,g=235,b=235;
  float num = 0, n = 0, angle, s;

  Particle(float a) {
    //float r = random(90);
    loc = new PVector(width/2+random(-area/2, area/2), height/2+random(-area/2, area/2));
    vel = new PVector();
    angle = a;
  }

  void draw() {
    s = random(30, 100);
    noStroke();
    fill(r,g,b);
    ellipse(loc.x, loc.y, s, s);
  }

  void move() {
    n+=norm(num-n, -90, 90);
    vel = (new PVector(sin(radians(n+angle)), cos(radians(n+angle))));
    loc.add(vel);
    // Change desired angle
    if ((frameCount%50)==0) {
      if (random(1) > 0.5) {
        num+=90;
      } else {
        num-=90;
      }
    }
  }
  
  void boundary(){
    if(loc.x < area){
      loc.x = width-area; 
    }
    
    if(loc.x > width-area){
      loc.x = area; 
    }
    
    if(loc.y < area){
      loc.y = height-area; 
    }
    
    if(loc.y > height-area){
      loc.y = area; 
    }
  }
  
  void change_color(float rr,float gg,float bb){
    r=rr;
    g=gg;
    b=bb;
  }
}
