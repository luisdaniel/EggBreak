// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2011
// PBox2D example

// A rectangular box
class Polygon {

  // We need to keep track of a Body and a width and height
  Body body;
  color col;
  float an;
  Vec2 v;
  Vec2 vec1;
  Vec2 vec2;
  Vec2 vec3;
  Vec2 vec4;
  PImage p;

  // Constructor
  Polygon(float x, float y, float a, Vec2 vel, Vec2 v1, Vec2 v2, Vec2 v3, String filename) {
    v = vel;
    an = a;
    vec1 = v1;
    vec2 = v2;
    vec3 = v3;
    p = loadImage(filename);
    makeBody(new Vec2(x, y));
    col = color(175);
    body.setUserData(this);
  }
  
  Polygon(float x, float y, float a, Vec2 vel, Vec2 v1, Vec2 v2, Vec2 v3, Vec2 v4, String filename) {
    v = vel;
    an = a;
    vec1 = v1;
    vec2 = v2;
    vec3 = v3;
    vec4 = v4;
    p = loadImage(filename);
    makeBody(new Vec2(x, y));
    col = color(175);
    body.setUserData(this);
  }
  
  
  
  

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  // Is the particle ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height) {
      killBody();
      return true;
    }
    return false;
  }

  // Drawing the box
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
    translate(pos.x,pos.y);
    rotate(-a);
    fill(175);
    stroke(0);
    image(p, 0,0);
    /*
    beginShape();
    // For every vertex, convert to pixel vector
    for (int i = 0; i < vertices.length; i++) {
      Vec2 v = box2d.vectorWorldToPixels(vertices[i]);
      vertex(v.x,v.y);
    }
    endShape(CLOSE);
    */
    popMatrix();
  }

  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center) {

    // Define a polygon (this is what we use for a rectangle)
    PolygonDef sd = new PolygonDef();
    sd.addVertex(box2d.vectorPixelsToWorld(vec1));
    sd.addVertex(box2d.vectorPixelsToWorld(vec2));
    sd.addVertex(box2d.vectorPixelsToWorld(vec3));
    if (vec4 != null) {
      sd.addVertex(box2d.vectorPixelsToWorld(vec4));
    }


    // Parameters that affect physics
    sd.density = 1.0f;
    sd.friction = 0.3f;
    sd.restitution = 0.5f;

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createShape(sd);
    body.setMassFromShapes();

    // Give it some initial random velocity
    body.setLinearVelocity(v);
  }
}


