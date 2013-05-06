import pbox2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import sms.*;

PBox2D box2d;
PImage b;
Vec2 pos;
Vec2 velocity;
float angle;

ArrayList<Boundary> boundaries;
ArrayList<Egg> eggs;
ArrayList<Box> boxes;
ArrayList<Polygon> polygons;
Pedestal pedestal;
Egg egg;
boolean readyForSquares = false;
boolean boxesAdded = false;


void setup() {
  size(700, 541);
  smooth();

  b = loadImage("wall.jpg");


  //initialize box2d physics and create world
  box2d = new PBox2D(this);
  box2d.createWorld();
  box2d.listenForCollisions();


  //set custom gravity:


  //create arrayLists
  boundaries = new ArrayList<Boundary>();
  boundaries.add(new Boundary(width/2, -5, width, 10));
  boundaries.add(new Boundary(width/2, height+5, width, 10));
  boundaries.add(new Boundary(width +5, height/2, 10, height));
  boundaries.add(new Boundary(-5, height/2, 10, height));
  boxes = new ArrayList<Box>();
  polygons = new ArrayList<Polygon>();
  eggs = new ArrayList<Egg>();
  pedestal = new Pedestal();
  eggs.add(new Egg(width/2, height/2 + 40));

  pos = new Vec2();


  //box2d.setGravity(0, -20);
  //p = new Pair(width/2, height/2 +35);
}



void draw() {
  background(255);
  image(b, 0, 0);
  int[] vals = Unimotion.getSMSArray();
  float x = map(vals[0], -260, 260, 0, PI);
  if (x > 1.54 && x < 1.56) {
    box2d.setGravity(0, -20);
  } 
  else {
    box2d.setGravity(40*cos(x), -40*sin(x));
  }

  //step through time:
  box2d.step();

  for (Boundary wall: boundaries) {
    wall.display();
  }

  pedestal.display();
  for (int i = eggs.size()-1; i >= 0; i--) {
    Egg e = eggs.get(i);
    e.display();
    // Particles that leave the screen, we delete them
    // (note they have to be deleted from both the box2d world and our list
    if (e.done()) {
      eggs.remove(i);
    }
  }

  if (readyForSquares) {
    displaySquares();
  }
}





void mousePressed() {

  //Egg e = new Egg(mouseX, mouseY);
  //eggs.add(e);

  //
  //  Pair p = new Pair(mouseX, mouseY);
  //  pairs.add(p);
}


void addContact(ContactPoint cp) {
  println("Collision!");
  //get both shapes
  Shape s1 = cp.shape1;
  Shape s2 = cp.shape2;
  //get both bodies
  Body b1 = s1.getBody();
  Body b2 = s2.getBody();

  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();


  String c1 = o1.getClass().getName();
  String c2 = o2.getClass().getName();

  if (o1.getClass() == Egg.class && o2.getClass() == Boundary.class) {
    println("BOOM!");
    Egg e = (Egg) o1;
    pos = new Vec2(e.getX(), e.getY());
    angle = e.getA();
    velocity = e.getVel();
    readyForSquares = true;
    e.markForDeletion();
  }
  if (o2.getClass() == Egg.class && o1.getClass() == Boundary.class) {
    println("BOOM!");
    Egg e = (Egg) o2;
    pos = new Vec2(e.getX(), e.getY());
    velocity = e.getVel();
    angle = e.getA();
    readyForSquares = true;
    e.markForDeletion();
  }
}




//continue to collide, resisting each other
void persistContact(ContactPoint cp) {
}

void removeContact(ContactPoint cp) {
}

void resultContact(ContactResult cr) {
}



void displaySquares() {
  if (!boxesAdded) {

    //angle = 0;
    //first quadrant boxes
    boxes.add(new Box(pos.x, pos.y, angle, velocity, "s1.png"));
    boxes.add(new Box(pos.x, pos.y-10, angle, velocity, "s4.png"));
    boxes.add(new Box(pos.x, pos.y-20, angle, velocity, "s7.png"));
    boxes.add(new Box(pos.x, pos.y-30, angle, velocity, "s10.png"));
    boxes.add(new Box(pos.x + 10, pos.y, angle, velocity, "s2.png"));
    boxes.add(new Box(pos.x + 10, pos.y-10, angle, velocity, "s5.png"));
    boxes.add(new Box(pos.x + 10, pos.y-20, angle, velocity, "s8.png"));
    boxes.add(new Box(pos.x + 10, pos.y-30, angle, velocity, "s11.png"));
    boxes.add(new Box(pos.x + 20, pos.y, angle, velocity, "s3.png"));
    boxes.add(new Box(pos.x + 20, pos.y-10, angle, velocity, "s6.png"));
    boxes.add(new Box(pos.x + 20, pos.y-20, angle, velocity, "s9.png"));
    //polygons
    polygons.add(new Polygon(pos.x, pos.y-50, angle, velocity, new Vec2(0, 0), new Vec2(0, 10), new Vec2(20, 10), "p1.png"));
    polygons.add(new Polygon(pos.x+20, pos.y-40, angle, velocity, new Vec2(0, 0), new Vec2(0, 10), new Vec2(10, 10), new Vec2(10, 5), "p2.png"));
    polygons.add(new Polygon(pos.x+ 30, pos.y-30, angle, velocity, new Vec2(0, 0), new Vec2(0, 35), new Vec2(10, 35), "p3.png"));
    
    //fourth quadrant boxes
    boxes.add(new Box(pos.x, pos.y+10, angle, velocity, "s12.png"));
    boxes.add(new Box(pos.x, pos.y+20, angle, velocity, "s15.png"));
    boxes.add(new Box(pos.x, pos.y+30, angle, velocity, "s17.png"));
    boxes.add(new Box(pos.x, pos.y+40, angle, velocity, "s19.png"));
    boxes.add(new Box(pos.x + 10, pos.y, angle, velocity, "s13.png"));
    boxes.add(new Box(pos.x + 10, pos.y + 10, angle, velocity, "s16.png"));
    boxes.add(new Box(pos.x + 10, pos.y + 20, angle, velocity, "s18.png"));
    boxes.add(new Box(pos.x + 20, pos.y + 10, angle, velocity, "s14.png"));
    //polygons
    polygons.add(new Polygon(pos.x + 30, pos.y + 15, angle, velocity, new Vec2(0, 0), new Vec2(10, -15), new Vec2(0, -15), "p4.png"));
    polygons.add(new Polygon(pos.x + 20, pos.y + 30, angle, velocity, new Vec2(0, 0), new Vec2(10, -15), new Vec2(10, -20), new Vec2(0, -20), "p5.png"));
    polygons.add(new Polygon(pos.x + 10, pos.y + 45, angle, velocity, new Vec2(0, 0), new Vec2(10, -15), new Vec2(0, -15), "p6.png"));
    polygons.add(new Polygon(pos.x, pos.y + 45, angle, velocity, new Vec2(0, 0), new Vec2(10, 0), new Vec2(10, -5), new Vec2(0, -5), "p7.png"));

    //second quadrant boxes
    boxes.add(new Box(pos.x - 10, pos.y, angle, velocity, "s20.png"));
    boxes.add(new Box(pos.x - 10, pos.y-10, angle, velocity, "s23.png"));
    boxes.add(new Box(pos.x - 10, pos.y-20, angle, velocity, "s26.png"));
    boxes.add(new Box(pos.x - 10, pos.y-30, angle, velocity, "s29.png"));
    boxes.add(new Box(pos.x - 20, pos.y, angle, velocity, "s21.png"));
    boxes.add(new Box(pos.x - 20, pos.y-10, angle, velocity, "s24.png"));
    boxes.add(new Box(pos.x - 20, pos.y-20, angle, velocity, "s27.png"));
    boxes.add(new Box(pos.x - 20, pos.y-30, angle, velocity, "s30.png"));
    boxes.add(new Box(pos.x - 30, pos.y, angle, velocity, "s22.png"));
    boxes.add(new Box(pos.x - 30, pos.y-10, angle, velocity, "s25.png"));
    boxes.add(new Box(pos.x - 30, pos.y-20, angle, velocity, "s28.png"));
    //polygons
    polygons.add(new Polygon(pos.x, pos.y-50, angle, velocity, new Vec2(0, 0), new Vec2(-20, 10), new Vec2(0, 10), "p8.png"));
    polygons.add(new Polygon(pos.x - 20, pos.y-40, angle, velocity, new Vec2(0, 0), new Vec2(-10, 5), new Vec2(-10, 10), new Vec2(0, 10), "p9.png"));
    polygons.add(new Polygon(pos.x - 30, pos.y-30, angle, velocity, new Vec2(0, 0), new Vec2(-10, 35), new Vec2(0, 35), "p10.png"));
    
    //third quadrant boxes
    boxes.add(new Box(pos.x-10, pos.y+10, angle, velocity, "s31.png"));
    boxes.add(new Box(pos.x-10, pos.y+20, angle, velocity, "s34.png"));
    boxes.add(new Box(pos.x-10, pos.y+30, angle, velocity, "s36.png"));
    boxes.add(new Box(pos.x-10, pos.y+40, angle, velocity, "s38.png"));
    boxes.add(new Box(pos.x - 20, pos.y, angle, velocity, "s32.png"));
    boxes.add(new Box(pos.x - 20, pos.y + 10, angle, velocity, "s35.png"));
    boxes.add(new Box(pos.x - 20, pos.y + 20, angle, velocity, "s37.png"));
    boxes.add(new Box(pos.x - 30, pos.y + 10, angle, velocity, "s33.png"));
    //polygons
    polygons.add(new Polygon(pos.x - 30, pos.y + 15, angle, velocity, new Vec2(0, 0), new Vec2(0, -15), new Vec2(-10, -15), "p11.png"));
    polygons.add(new Polygon(pos.x - 20, pos.y + 30, angle, velocity, new Vec2(0, 0), new Vec2(0, -20), new Vec2(-10, -20), new Vec2(-10, -15), "p12.png"));
    polygons.add(new Polygon(pos.x - 10, pos.y + 45, angle, velocity, new Vec2(0, 0), new Vec2(0, -15), new Vec2(-10, -15), "p13.png"));
    polygons.add(new Polygon(pos.x, pos.y + 45, angle, velocity, new Vec2(0, 0), new Vec2(0, -5), new Vec2(-10, -5), new Vec2(-10, 0), "p14.png"));


    boxesAdded = true;
  }
  for (Box b: boxes) {
    b.display();
  }
  for (Polygon p: polygons) {
    p.display();
  }
}

