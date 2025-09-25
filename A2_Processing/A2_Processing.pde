int a[][] = {
            {8,7,6,5,4,3,1,9,2},
            {5,4,3,2,1,9,7,6,8},
            {2,1,9,8,7,6,4,3,5},

            {1,9,8,7,6,5,3,2,4},
            {4,3,2,1,9,8,6,5,7},
            {7,6,5,4,3,2,9,8,1},

            {3,2,1,9,8,7,5,4,6},
            {6,5,4,3,2,1,8,7,9},
            {9,8,7,6,5,4,2,1,3}
        };
        
int CellSize = 50;
int BoardSize = 9 * CellSize;
        
        
void setup(){
    size(450,450);
    drawBoard();
}

void draw(){

}

void drawBoard(){
    fill(0);
    for (int i = 0; i < 9 ; i++){
        if ((i % 3) == 0) { strokeWeight(3); }
        else { strokeWeight(1); }
        
        line(0,CellSize*i,BoardSize,CellSize*i);
        line(CellSize * i, 0 , i * CellSize , BoardSize);
    }
}
