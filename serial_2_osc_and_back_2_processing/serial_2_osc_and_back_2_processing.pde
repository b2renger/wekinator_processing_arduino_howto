import oscP5.*;
import netP5.*;

import processing.serial.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

Serial myPort; 

int p1, p2, p3;

void setup() {
  size(400, 400);
  frameRate(25);

  oscP5 = new OscP5(this, 12001);
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);

  printArray(Serial.list());
  String portName = Serial.list()[3]; // change accordingly
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
}

void draw() {
  background(0);
}


void serialEvent (Serial myPort) {
  try {
    while (myPort.available() > 0) {
      String inBuffer = myPort.readStringUntil('\n');
      if (inBuffer != null) {
        if (inBuffer.substring(0, 1).equals("{")) {
          JSONObject json = parseJSONObject(inBuffer);
          if (json == null) {
            //println("JSONObject could not be parsed");
          } else {

            p1    = json.getInt("p1"); 
            p2    = json.getInt("p2");
            p3    = json.getInt("p3");
            //println(p1, p2, p3);

            // osc inputs should be bundled in one message
            OscMessage myMessage = new OscMessage("/wek/inputs/");  
            myMessage.add(float(p1));  // each value should be a float
            myMessage.add(float(p2)); 
            myMessage.add(float(p3)); 
            oscP5.send(myMessage, myRemoteLocation);
          }
        } else {
        }
      }
    }
  } 
  catch (Exception e) {
  }
}


// osc receive
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/test")==true) {
    int v = theOscMessage.get(0).intValue();     
    println(" values: "+v);
    return;
  }  
  println("### received an osc message. with address pattern "+theOscMessage.addrPattern());
}
