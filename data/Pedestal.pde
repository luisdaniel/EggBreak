


class Pedestal {
  PImage pic;
  Body body;
  float w;
  float w2;
  float h;
  float x;
  float y;
  
  Pedestal() {
    pic = loadImage("pedestal.png");
    pic.resize(200, 200);
    w = 25;
    w2 = 68;
    h = 170;
    x = width/2;
    y = height - h/2;
    makeBody();
  }
  
  
  void display() {
    
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(175);
    stroke(0);
    image(pic, -100, -100);
    /*
    rect(0, 0, w, h);
    rect(0, -h/2, w2, w);
    rect(0, h/2, w2, w);
    */
    popMatrix();
  }
  
  void makeBody() {
    
    PolygonDef sd1 = new PolygonDef();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    float box2dW2 = box2d.scalarPixelsToWorld(w2/2);
    sd1.setAsBox(box2dW, box2dH);
    sd1.density = 5.0f;
    sd1.friction = 1.0f;
    sd1.restitution = 0.5f;
    
    
    PolygonDef sd2 = new PolygonDef();
    Vec2 offset;
    sd2.setAsBox(box2dW2, box2dW, new Vec2(0, -8), 0);
    sd2.density = 1.0f;
    sd2.friction = 0.3f;
    sd2.restitution = 0.5f;
    
    PolygonDef sd3 = new PolygonDef();
    Vec2 offset2 = new Vec2(0, 8.5);
    sd3.setAsBox(box2dW2, box2dW, offset2, 0);
    sd3.density = 1.0f;
    sd3.friction = 0.3f;
    sd3.restitution = 0.5f;
    
    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(new Vec2(x, y)));
    
    body = box2d.createBody(bd);
    body.createShape(sd1);
    body.createShape(sd2);
    body.createShape(sd3);
    body.setMassFromShapes();
    
    //body.setLinearVelocity(new Vec2(0, 0));
    //body.setAngularVelocity(new Vec2(0, 0));
    
        body.setUserData(this);

    
  }
  
}
