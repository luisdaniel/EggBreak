

class Box {
  Body body;
  float w;
  float h;
  color col;
  float an;
  Vec2 v;
  PImage s;

  Box(float x, float y, float a, Vec2 vel, String filename) {
    w = 10;
    h = 10;
    v = vel;
    an = a;
    s = loadImage(filename);
    makeBody(new Vec2(x, y), w, h);
    col = color(175);
    body.setUserData(this);
  }

  Box(float x, float y, float a, Vec2 vel) {
    w = 10;
    h = 10;
    v = vel;
    an = a;
    makeBody(new Vec2(x, y), w, h);
    col = color(175);
    body.setUserData(this);
  }

  void killBody() {
    box2d.destroyBody(body);
  }

  boolean done() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y > height + w*h) {
      killBody();
      return true;
    }
    return false;
  }

  void display() {
    //get the body's screen position so we know where to draw the box:
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(col);
    stroke(0);
    if (s !=null) {
      image(s, 0,0);
    }
    //rect(0, 0, w, h);
    popMatrix();
  }

  void change() {
    col = color(255, 0, 0);
    body.setLinearVelocity(new Vec2(random(-5, 0), random(2, 5)));
  }

  void makeBody(Vec2 center, float w_, float h_) {

    //define a polygon:
    PolygonDef sd = new PolygonDef();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    //parameters that affect physics:
    sd.density = 1.0f;
    sd.friction = 1.0f;
    sd.restitution = 0.5f;

    //define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(center));
    bd.angle = an;

    body = box2d.createBody(bd);
    body.createShape(sd);
    body.setMassFromShapes();
    //body.getXForm(box2d.coordPixelsToWorld(center), an);
    //body.setAngle(angle);
    body.setLinearVelocity(v);
  }
}

