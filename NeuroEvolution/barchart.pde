class BarChart {
  
  PVector topLeftPosition;
  float chartWidth;
  float chartHeight;
  int[] series;
  String chartLabel;
  
  BarChart(PVector pos, float w, float h, int[] series, String chartLabel){
    topLeftPosition = pos;
    chartWidth = w;
    chartHeight = h;
    this.series = series;
    this.chartLabel = chartLabel;
  }
  
  void render(){
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
    
    //bars and x-axis labels
    float maxBarWidth = chartWidth / series.length;
    float gap = 5;
    float highestValue = max(series);
    for (int i = 0; i < series.length; i++){
      float x = topLeftPosition.x + i * maxBarWidth + gap;
      float y = topLeftPosition.y + chartHeight - ((series[i] / highestValue) * chartHeight);
      noStroke();
      fill(200);
      rectMode(CORNERS);
      rect(x, y, x + maxBarWidth - 2 * gap, topLeftPosition.y + chartHeight);
      //labels
      float textX = topLeftPosition.x + (i + 0.5) * maxBarWidth;
      float textY = topLeftPosition.y + chartHeight;
      textAlign(CENTER, TOP);
      text(i, textX, textY);
    }
    //y-axis label
    text(int(highestValue), topLeftPosition.x - 10, topLeftPosition.y);
  }
  
  
}
