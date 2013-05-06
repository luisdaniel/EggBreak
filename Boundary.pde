

class Boundary {

  //A boundary is a simple rectangle with x, y, width and height
  float x;
  float y;
  float w;
  float h;
  // but we also have to make a body for Box2d to know about it
  Body b;

  Boundary(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;

    //figure out the box 2d coordinates:
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    Vec2 center = new Vec2(x, y);

    //define the polygon:
    PolygonDef sd = new PolygonDef();
    sd.setAsBox(box2dW, box2dH);
    sd.density = 0; //no density means it won't move
    sd.friction = 0.3f;

    //create the body
    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(center));
    b = box2d.createBody(bd);
    b.createShape(sd);
    
    b.setUserData(this);
  }

  //draw the boundary, if it were at an angle, we'd have to do something fancier.
  void display() {
    fill(0);
    stroke(0);
    rectMode(CENTER);
    rect(x, y, w, h);
  }
}

