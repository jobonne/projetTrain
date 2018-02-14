public void setup(){
  size(1400, 800, JAVA2D);
}

public void draw(){
  rails();
}

void rails(){
  scale(0.9);//pour modifier l'échelle
  translate(150,50);//pour bien centrer
  background(255);//fond blanc
  noFill();//pour ne pas remplir les arcs de cercle
  strokeWeight(4);//épaisseur trait
  stroke(255,0,0);//rouge

  arc(1000,350,621,621,radians(-120),radians(90));//A
  arc(1000-4*300/2,350,621,621,radians(60),radians(270));//B
  arc(1000-5*300/2,350,621,621,radians(90),radians(270));//C
  for(int i=0;i<5;i++){
  line(1000-300/2*i,350+621/2,1000-300/2*(i+1),350+621/2);//
  }//AC bas
  for(int i=0;i<5;i++){
  line(1000-300/2*i,350-621/2,1000-300/2*(i+1),350-621/2);
  }//AC haut
  
  stroke(0);//noir
  arc(1000,350,573,573,radians(-120),radians(90));//A
  arc(1000-4*300/2,350,573,573,radians(60),radians(270));//B
  arc(1000-5*300/2,350,573,573,radians(90),radians(270));//C
  for(int i=0;i<5;i++){
  line(1000-300/2*i,350+573/2,1000-300/2*(i+1),350+573/2);
  }//AC bas
  for(int i=0;i<5;i++){
  line(1000-300/2*i,350-573/2,1000-300/2*(i+1),350-573/2);
  }//AC haut
  
  stroke(255,0,255);//magenta
  arc(1000, 350, 623,621, radians(-180), radians(-120));//D
  arc(1000-4*300/2,350,575,573,radians(0),radians(60));//E
  stroke(150);//gris
  arc(1000, 350, 575,573, radians(-180), radians(-120));//D
  arc(1000-4*300/2,350,623,621,radians(0),radians(60));//E
  stroke(0,255,0);//vert -- séparation des rails
  for(int i=-6;i<4;i++){
  line(1000+573/2*cos(PI/6*i),350+573/2*sin(PI/6*i)
  ,1000+621/2*cos(PI/6*i),350+621/2*sin(PI/6*i));
  }//A et D
  for(int i=1;i<6;i++){
  line(1000-300/2*i,350+573/2,1000-300/2*i,350+621/2);
  }//AC bas
  for(int i=1;i<10;i++){
  line(1000-4*300/2+573/2*cos(PI/6*i),350+573/2*sin(PI/6*i)
  ,1000-4*300/2+621/2*cos(PI/6*i),350+621/2*sin(PI/6*i)
  );
  }//E et B
  for(int i=4;i<10;i++){
  line(1000-5*300/2+573/2*cos(PI/6*i),350+573/2*sin(PI/6*i)
  ,1000-5*300/2+621/2*cos(PI/6*i),350+621/2*sin(PI/6*i)
  );
  }//C
  for(int i=1;i<4;i++){
  line(1000-300/2*i,350-573/2,1000-300/2*i,350-621/2);
  }//AC haut
  
  stroke(255,255,0);//jaune -- discontinuités électriques
  strokeWeight(10);//épaisseur du trait
  line(1000-4*300/2+573/2*cos(PI/6*2),350+573/2*sin(PI/6*2)
  ,1000-4*300/2+621/2*cos(PI/6*2),350+621/2*sin(PI/6*2)
  );//entre E et B
  line(1000+573/2*cos(-PI/6*4),350+573/2*sin(-PI/6*4)
  ,1000+621/2*cos(-PI/6*4),350+621/2*sin(-PI/6*4));//entre A et D
}