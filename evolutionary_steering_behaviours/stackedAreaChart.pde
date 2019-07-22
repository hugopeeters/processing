class StackedAreaChart {

  PVector topLeftPosition;
  float chartWidth;
  float chartHeight;
  ArrayList<int[]> series;
  String chartLabel;

  StackedAreaChart(PVector pos, float w, float h, ArrayList<int[]> series, String chartLabel) {
    topLeftPosition = pos;
    chartWidth = w;
    chartHeight = h;
    this.series = series;
    this.chartLabel = chartLabel;
  }

  void render() {
    noFill();
    stroke(255);
    strokeWeight(1);
    //y-axis
    line(topLeftPosition.x, topLeftPosition.y, topLeftPosition.x, topLeftPosition.y + chartHeight);
    //x-axis
    line(topLeftPosition.x, topLeftPosition.y + chartHeight, topLeftPosition.x + chartWidth, topLeftPosition.y + chartHeight);
    //title
    pushMatrix();
    translate(topLeftPosition.x, topLeftPosition.y + chartHeight / 2);
    rotate(-PI/2);
    textAlign(CENTER, BOTTOM);
    noStroke();
    fill(255);
    text(chartLabel, 0, 0);
    popMatrix();

    //data
    float maxBarWidth = chartWidth / series.size();
    for (int i = 0; i < series.size(); i++) {
      int[] dataset = series.get(i);
      float sum = sum(dataset);
      float x = topLeftPosition.x + i * maxBarWidth;
      float y1 = topLeftPosition.y;
      float y2 = y1;
      for (int j = 0; j < dataset.length; j++) {
        y2 += chartHeight * (dataset[j] / sum);
        rectMode(CORNERS);
        noStroke();
        fill(ancColors[j]);
        rect(x, y1, x + maxBarWidth, y2);
        y1 = y2;
      }
      //labels x-axis
      //float textX = topLeftPosition.x + (i + 0.5) * maxBarWidth;
      //float textY = topLeftPosition.y + chartHeight;
      //textAlign(CENTER, TOP);
      //text(i, textX, textY);
    }
    //labels y-axis
  }
}


//global functions

int sum(int[] arr) {
  int total = 0;
  for (int i : arr) {
    total += i;
  }
  return total;
}

color[] createColorArray(int sz){
  color[] colArr = new color[sz];
  for (int i = 0; i < sz; i++) {
    int r = round(random(255));
    int g = round(random(255));
    int b = round(random(255));
    colArr[i] = color(r, g, b);
  }
  return colArr;
}
