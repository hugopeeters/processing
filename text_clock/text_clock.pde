/*
HETxISVIJF
TIENxKWART
xVOORxOVER
xHALFxEENx
TWEExDRIEx
xVIERxVIJF
ZESxZEVENx
ACHTxNEGEN
xTIENxELFx
TWAALFxUUR
*/

int[][][] uur = {{{3,6},{3,7},{3,8}}, {}};

void setup(){
  size(600,600);
}

void draw(){
  background(0);
  int hour = hour();
  int minute = minute();
  
  if (minute < 5){
    //het is <hour> uur
  } else if (minute < 10){
    //het is vijf over <hour>
  } else if (minute < 15){
    //het is tien over <hour>
  } else if (minute < 20){
    //het is kwart over <hour>
  } else if (minute < 25){
    //het is tien voor half <hour + 1>
  } else if (minute < 30){
    //het is vijf voor half <hour + 1>
  } else if (minute < 35){
    //het is half <hour + 1>
  } else if (minute < 40){
    //het is vijf over half <hour + 1>
  } else if (minute < 45){
    //het is tien over half <hour + 1>
  } else if (minute < 50){
    //het is kwart voor <hour + 1>
  } else if (minute < 55){
    //het is tien voor <hour + 1>
  } else {
    //het is vijf voor <hour + 1>
  }
}
