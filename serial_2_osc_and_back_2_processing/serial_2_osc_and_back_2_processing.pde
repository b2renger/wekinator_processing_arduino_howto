import oscP5.*;
import netP5.*;

import processing.serial.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

Serial myPort; 

int p1, p2, p3;

String txt = "";

void setup() {
  size(400, 400);
  frameRate(25);

  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 6448);

  printArray(Serial.list());
  String portName = Serial.list()[3]; // change accordingly
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
}

void draw() {
  background(0);
  
  textAlign(CENTER,CENTER);
  fill(255);
  text(txt, width*0.5,height*0.5);
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
  if (theOscMessage.checkAddrPattern("/wek/outputs")==true) {
    float v = theOscMessage.get(0).floatValue();
    if (v == 1){
      txt="waiting for input";
    }
    else if (v ==2){
      txt = " OUCH ! ";
    }
     else if (v ==3){
      txt = " it tickles ^^ ";
    }
     else if (v ==4){
      txt = " that's nicer :) ";
    }
    
    
    
  }
  if (theOscMessage.checkAddrPattern("/output_1")==true) {
    //int v = theOscMessage.get(0).intValue();     
    println("iddle");
    txt="waiting for input";
    return;
  }  
  if (theOscMessage.checkAddrPattern("/output_2")==true) {
    //int v = theOscMessage.get(0).intValue();     
    println("ouch !");
    txt = " OUCH ! ";
    return;
  }  
  
   if (theOscMessage.checkAddrPattern("/output_3")==true) {
    //int v = theOscMessage.get(0).intValue();     
    println("scratch ...");
    txt = " scratch that ";
    return;
  }  
  
  if (theOscMessage.checkAddrPattern("/output_4")==true) {
    //int v = theOscMessage.get(0).intValue();     
    println("nice :)");
    txt = "that's nicer :)";
    return;
  }  
  println("### received an osc message. with address pattern "+theOscMessage.addrPattern());
}
