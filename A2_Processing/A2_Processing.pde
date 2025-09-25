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
int Board[][] = new int[9][9];
int CellSize = 50;
int BoardSize = 9 * CellSize;
int Blank[] = new int[4];//invisible cols    

        
void setup(){
    size(450,450);
    drawBoard();
    printBoardTest();
}

void draw(){

}

void printBoardTest(){
    for (int i = 0; i < a.length ; i++){
        for (int j = 0; j < a[i].length ; j++){
            print(str(a[i][j]) + " ");
        }
        println("");
        if((i+1) % 3 == 0 ) { println(""); }
    }
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

void randomBlank(){
    for (int i = 0 ; i < 7 ; i++){
        Blank[i] = int(random(0,9));
    }
}

void fillBoard(){
    for(int i = 0 ; i < 9 ; i++){
        for(int j = 0; j<9 ; j++){
            Board[i][j] = a[i][j];
        }
        for(int k = 0; k < 4 ;k++){
            int col = Blank[k];
            Board[i][col] = 0;
        }
    }
}
