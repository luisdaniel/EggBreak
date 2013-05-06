

class Egg {
  Body body;
  PImage p;
  color col;
  boolean markForDeletion = false;

  Egg(float x, float y) {
    makeBody(new Vec2(x, y));
    col = color(175);
    body.setUserData(this);
    p = loadImage("faberge.png");
    p.resize(p.width/2, p.height/2);
  }


  void markForDeletion() {
    markForDeletion = true;
    
  }
  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }
  
  // Change color when hit
  void change() {
    col = color(255,0,0); 
  }

  // Is the particle ready for deletion?
  boolean done() {
    if (markForDeletion) {
       killBody();
       return true;
    }

    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height+50) {
      killBody();
      return true;
    }
    return false;
  }

  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();

    // Ask for the shape
    PolygonShape ps = (PolygonShape) body.getShapeList();
    // Get the array of vertices
    Vec2[] vertices = ps.m_vertices;

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    image(p, -p.width/2, -p.height/2);
    fill(col);
    stroke(0);
    /*
    beginShape();
    // For every vertex, convert to pixel vector
    for (int i = 0; i < vertices.length; i++) {
      Vec2 v = box2d.vectorWorldToPixels(vertices[i]);
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
    */
    popMatrix();

    //killBody();
  }


  void makeBody(Vec2 center) {


    PolygonDef sd = new PolygonDef();
    sd.addVertex(box2d.vectorPixelsToWorld(new Vec2(10, 45)));
    //sd.addVertex(box2d.vectorPixelsToWorld(new Vec2(30, 20)));
    sd.addVertex(box2d.vectorPixelsToWorld(new Vec2(40, 0)));
    sd.addVertex(box2d.vectorPixelsToWorld(new Vec2(30, -35)));
    sd.addVertex(box2d.vectorPixelsToWorld(new Vec2(0, -50)));
    sd.addVertex(box2d.vectorPixelsToWorld(new Vec2(-30, -35)));
    sd.addVertex(box2d.vectorPixelsToWorld(new Vec2(-40, 0)));
    //sd.addVertex(box2d.vectorPixelsToWorld(new Vec2(-30, 20)));
    sd.addVertex(box2d.vectorPixelsToWorld(new Vec2(-10, 45)));
    sd. density = 1.0f;
    sd.friction = 0.3f;
    sd.restitution = 0.5f;

    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);

    body.createShape(sd);
    body.setMassFromShapes();
  }
  
  
  
  float getX() {
    Vec2 pos2 = box2d.getBodyPixelCoord(body);
    return pos2.x;
  }
  
  float getY() {
    Vec2 pos2 = box2d.getBodyPixelCoord(body);
    return pos2.y;
  }
  
  float getA() {
    return body.getAngle();
  }
  
  public Vec2 getVel() {
    return body.getLinearVelocity();
  }
}

