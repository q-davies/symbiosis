import processing.sound.*;

int numShapes = int(random(500,500));
int numColors = 7;
float [][] colors = new float[numColors][3];
float aF = 0.02;
int alpha;
float bgR = random(.1,.2);
float bgG = random(0,.1);
float bgB = random(.1,.2);
boolean startDrawing = true;
Neuron[] neurons = new Neuron[numShapes];
class Neuron {
  float[] colors;
  int rotation;
  Neuron(float[] c, int r) {
    colors = c;
    rotation = r;
  }
}

AudioIn input;
Amplitude loudness;
void setup() {
  fullScreen();
  noCursor();
  background(int(255*bgR),int(255*bgG),int(255*bgB));
  for(int i=0; i<numColors; i++) {
    float [] newColor = {random(.5,.9),random(.5,.9),random(.5,.9)};
    colors[i] = newColor;
  }
  
  for(int i=0; i < numShapes; i++) {
    int r = int(random(360));
    int nR = int(random(numColors));
    int nG = int(random(numColors));
    int nB = int(random(numColors));
    float[] c = {colors[nR][0],colors[nG][1],colors[nB][2]};
    neurons[i] = new Neuron(c,r);  
  }
  
  input = new AudioIn(this,0);
  input.start();
  loudness = new Amplitude(this);
  loudness.input(input);
}

void draw() {
  float volume = loudness.analyze();
  background(int(255*(bgR)),int(255*(bgG)),int(255*(bgB)));
  strokeWeight(80);
  translate(width/2.5,height/2.5);
  scale(0.2);
  if(startDrawing) {
    for(int i = 0; i < numShapes; i++) {
      pushStyle();
      alpha = int(255*(volume+0.01));
      translate((int(random(width))/15)+40,(int(random(height))/15)+30);
      rotate(radians(neurons[i].rotation));
      neurons[i].colors[0] = volume+0.5;
      stroke(int(255*neurons[i].colors[0]),int(255*neurons[i].colors[1]),int(255*neurons[i].colors[2]),alpha);
      fill(int(255*neurons[i].colors[0]),int(255*neurons[i].colors[1]),int(255*neurons[i].colors[2]),alpha);
      beginShape();
      vertex(0,0);
      bezierVertex(100,-20,100,175,300,525);
      bezierVertex(500,800,600,425,300,400);
      endShape();
      popStyle();
    }
  }
}
