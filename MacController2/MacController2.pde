import processing.serial.*;

Serial myPort;
String val;
boolean firstContact = true;

void setup() {
  size(400, 400);
  //find the correct serial port to use
  String[] serialPorts = Serial.list();
  for (int i = 0; i < serialPorts.length; i++) {
    if (null != match(serialPorts[i], "cu.usbmodem")) {
      myPort = new Serial(this, serialPorts[i], 115200);
    }
  }
  //read data from the serial port until the \n character
  myPort.bufferUntil('\n');
}

void draw() {
  background(51);
  ellipseMode(CENTER);
  fill(255);
  if (val != "A") {
    float d = map(int(val), 0, 1023, 10, width);
    ellipse(width/2, height/2, d, d);
  }
}

void serialEvent( Serial myPort) { 
  //as soon as serial data is coming in
  //read the packet
  val = myPort.readStringUntil('\n');

  //check it's not empty
  if (val != null) {
    val = trim(val); //trim whitespaces
    //println(val);

    if (firstContact == true) {
      //this is the first packet we receive
      //check it is the A to indicate the Arduino is ready to go
      if (val.equals("A")) { 
        myPort.clear(); 
        //ensure we never end up in this init section again
        firstContact = false; 
        //send out an A to indicate Processing is ready to go (one appears to be not enough)
        delay(300);
        myPort.write("A"); 
        println("contact");
      }
    } else { 
      //after initial handshake, so the variable val contains some actual data for us
      println(val);

      if (mousePressed == true) {
        myPort.write('1');
        println("1");
      }
    }
  }
}
