class Matrix{

    int rows;
    int cols;
    float[][] data;

    void Matrix(int rows, int cols){
        this.rows = rows;
        this.cols = cols;
        this.data = new float[rows][cols];
    }

    void randomize(){
        for (int i = 0; i < this.rows; i++){
        for (int j = 0; j < this.cols; i++){
            this.data[i][j] = random();
        }    
        }
    }

}