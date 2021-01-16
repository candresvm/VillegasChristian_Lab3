//          UNIVERSIDAD TECNICA DEL NORTE
//                  FICA-CITEL
//              SISTEMAS EMBEBIDOS
//                LABORATORIO 3

import processing.serial.*;
import controlP5.*;
ControlP5 cp5;
float x, y, a, b;
float dx, dy;
int balls = 3;
String s1 = "Presione select para recetear, le quedan 2 bolas";
String s2 = "Presione select para recetear, le queda 1 bola";
String e = "GAME OVER, precione select para jugar de nuevo";
final int BRICKS_ACROSS = 10, BRICKS_HIGH = 4;
boolean bricks[][] = new boolean[BRICKS_ACROSS][BRICKS_HIGH];
Serial port;
String dato;
int w=340;
PFont font;

void setup() {
  size(750, 500);
  cp5=new ControlP5(this);
  font = createFont("arial",30);
  cp5.addButton("INICIAR")
      .setPosition(280,200)
      .setSize(200,100)
      .setColorBackground(#00FAF8)
      .setColorActive(#14F780)
      .setColorForeground(#14E2F7)
      .setFont(font)
      ;
}

void resetBall() {
  x = width/2;
  y = height/2;
  dx = random(-2, 2);
  dy = 2;
}

void resetPaddle() {
  a = 0;
  b = 490;
}

void draw() {
  fill(#4A00FA);
  rect(0, 0, width, height);
  fill(0);
  rect(w, b, 150, 10);
  fill(#01058E);
  ellipse(x, y, 15, 15);
  x = x + dx;
  y = y + dy;
  for (int i = 0; i < BRICKS_ACROSS; i++) {
    for (int j = 0; j < BRICKS_HIGH; j++) {
      if (bricks[i][j]) {
        strokeWeight(4);
        stroke(0);
        fill(random(40,200),random(40,20),random(40,200));
        if (x >= i*75 && x <= i*75 + 75 && y >= j*25 && y <= j*25 + 25) {
          bricks[i][j] = false;
          fill (0, 0, 0, 0);
          if (x > i*75 && x < i*75 + 75) {
            dy = -dy;
          } else if (y > j*25 && y < j*25 + 25) {
            dx = -dx;
          }
        }
        rect(i*75, j*25, 75, 25);
      }
    }
  }

  if (x > 750) {
    dx = -2;
  } else if (x < 0) {
    dx = 2;
  } else if (y < 0) {
    dy = 2;
  } else if (y > 500) {
    outOfBounds();
  }
  if (x > w && x < (w + 150) && y > 490 && y < 500) {
    dy = -2;
  } 
  if (x > w && x < (w + 75) && y > 490 && y < 500) {
    dx = -2;
  } 
  if (x > (w + 75) && x < (w + 150) && y > 490 && y < 500) {
    dx = 2;
  }
}

void reset() {
  resetBall();
  resetPaddle();
  background(#00FAF8);
  loop();
}

void outOfBounds() {
  noLoop();
  balls--;
  if (balls == 2) {
    fill(255);
    textSize(20);
    text(s1, 175, 350);
  } else if (balls == 1) {
    fill(255);
    textSize(20);
    text(s2, 175, 350);
  } else if (balls == 0) {
    fill(255, 0, 0);
    textSize(25);
    text(e, 100, 350);
    balls = 3;
    resetBricks();
  }
}

void resetBricks() {
  for (int i = 0; i < BRICKS_ACROSS; i++) {
    for (int j = 0; j < BRICKS_HIGH; j++) {
      bricks[i][j] = true;
      if (bricks[i][j]) {
        fill(255);
      }
    }
  }
}

void serialEvent(Serial port){
  dato=port.readString();
    switch(dato){
      case "A":
          w=w-90;
      break;
      case "B":
          w=w+90;
      break;
      case "C":
        reset();
      break;
    }
}

public void INICIAR(){
  port=new Serial(this,"COM10",9600);
  cp5.setAutoDraw(false);
  background(#00FAF8);
  resetBall();
  resetPaddle();
  for (int i = 0; i < BRICKS_ACROSS; i++) {
    for (int j = 0; j < BRICKS_HIGH; j++) {
      bricks[i][j] = true;
    }
  }
}
