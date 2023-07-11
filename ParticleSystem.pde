/**
 * @author Daniel Shiffman
 */

// Adapted from Daniel Shiffman
// https://processing.org/examples/simpleparticlesystem.html

// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles

class ParticleSystem {
  ArrayList<Particle> particles;
  
  PVector position;
  PVector velocity = new PVector(0, -0.3);
  PVector acceleration = new PVector(0, -0.1);
  float lifespan = 127.0;  // half of 255, originally transparency depended on lifespan, so beware
  
  color centerColor = color(255, 255, 255);
  color borderColor = color(236, 77, 247);  // something between purple and pink
  
  int size = 6;

  ParticleSystem() {
    particles = new ArrayList<Particle>();
    ellipseMode(RADIUS);  // WARNING! ellipseMode forced, but not reverted anywhere later in the code! DO NOT use this ParticleSystem in other projects before resolving this (and very likely moving this line somewhere else)!
                          // (it is fine for this project because it does not draw ellipses anywhere)
  }

  // Init a new particle with mostly the current default values of ParticleSystem and add it.
  // (another reminder that Java doesn't have default argument values...)
  void addParticle(PVector pPosition) {
    addParticle(pPosition, velocity, acceleration, lifespan, centerColor, borderColor, size);
  }
  
  void addParticle(PVector pPosition, float pLifespan) {
    addParticle(pPosition, velocity, acceleration, pLifespan, centerColor, borderColor, size);
  }
  
  
  // -- Init a new particle completely directly. *This should be internal.*
  void addParticle(PVector pPosition, PVector pVelocity, PVector pAcceleration, float pLifespan,
                    color pCenterColor, color pBorderColor, int pSize) {
    particles.add(new Particle(pPosition, pVelocity, pAcceleration, pLifespan, pCenterColor, pBorderColor, pSize));
  }
  
  void EmitParticlesOnClick(PVector pCountRange, PVector pPosXOffsetRange, PVector pPosYOffsetRange, PVector pLifespanRange) {
     //SetCenterColor(color(255, 255, 255));
     SetBorderColor(color(236, 77, 247));
     int count = int(random(pCountRange.x, pCountRange.y));
     for (int i = 0; i < count; i++) {
        addParticle(new PVector(mouseX + random(pPosXOffsetRange.x, pPosXOffsetRange.y), mouseY + random(pPosYOffsetRange.x, pPosYOffsetRange.y),
                    random(pLifespanRange.x, pLifespanRange.y)));
     }
  }
  
  void EmitParticlesOnHover(PVector pCountRange, PVector pPosXOffsetRange, PVector pPosYOffsetRange, PVector pLifespanRange) {
     //SetCenterColor(color(255, 255, 255));
     SetBorderColor(color(255, 16, 16));
     int count = int(random(pCountRange.x, pCountRange.y));
     for (int i = 0; i < count; i++) {
        addParticle(new PVector(mouseX + random(pPosXOffsetRange.x, pPosXOffsetRange.y), mouseY + random(pPosYOffsetRange.x, pPosYOffsetRange.y),
                    random(pLifespanRange.x, pLifespanRange.y)));
     }
  }
  
  // builders (else defaults will be used, these set new defaults for future particles)
  void SetVelocity(PVector v) { velocity = v.copy(); }
  void SetAcceleration(PVector a) { acceleration = a.copy(); }
  void SetCenterColor(color c) { centerColor = c; }
  void SetBorderColor(color c) { borderColor = c; }
  void SetLifespan(float l) { lifespan = l; }
  void SetSize(int s) { size = s; }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}



// A simple Particle class

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  
  color centerColor;
  color borderColor;
  
  int size;

  Particle(PVector pPosition, PVector pVelocity, PVector pAcceleration, float pLifespan,
                    color pCenterColor, color pBorderColor, int pSize) {
    position = pPosition.copy();
    velocity = pVelocity.copy();
    acceleration = pAcceleration.copy();
    lifespan = pLifespan;
    centerColor = pCenterColor;
    borderColor = pBorderColor;
    size = pSize;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    // Warning: random(low, high) returns low if high < low! AKA, random(0, -0.5) returns 0 and the effect seemingly does not work!
    // Mind this when using positive or negative values here!
    //float min = min(0, acceleration.y);
    //float max = max(0, acceleration.y);
    velocity.add(new PVector(acceleration.x, random(acceleration.y, 0)/*random(min, max)*/));
    position.add(velocity);
    lifespan -= 1.0;
  }

  // Gradient mode: based on a center color and a border color, draw <resolution> number of ellipses over each other
  // (from border backwards to center, else they will overlap incorrectly)
  void drawGradient() {
    for (int r = size; r > 0; r-=2/*resolution*/) {
      color c = lerpColor(borderColor, centerColor, map(size - r, 0, size, 0, 1));
      fill(c, lifespan);
      ellipse(position.x, position.y, r, r);
    } 
  }

  // Method to display
  void display() {
    stroke(255, lifespan);
    /**
    fill(255, lifespan);
    ellipse(position.x, position.y, size, size);
    /**/
    drawGradient();
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
