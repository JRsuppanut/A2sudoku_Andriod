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

int rows , cols;

        
void setup(){
    size(450,550);
    textAlign(CENTER, CENTER);
    textSize(30);
    
    fillBoard();
    removeNumber(Board);
    printBoardTest();
    
    drawBoard();
    drawNumberInBoard();
}

void draw(){
    
}

void mouseClicked(){ 
    if(mouseY <= 450){
        rows = mouseY / CellSize;
        cols = mouseX / CellSize;
    }
    println("(" + rows + ", " + cols + ")");
}

void printBoardTest(){
    for (int row = 0; row < a.length ; row++){
        for (int col = 0; col < Board[row].length ; col++){
            if((col + 1) % 3 == 0){
                print(str(Board[row][col]) + "  ");
            }else { print(str(Board[row][col]) + " "); }
        }
        println("");
        if((row+1) % 3 == 0 ) { println(""); }
    }
}

void drawNumberInBoard(){
    fill(0);
    for(int row = 0 ; row < Board.length ; row++){
        for (int col = 0 ; col < Board[row].length ; col++){
            if (Board[row][col] != 0){
                text(Board[row][col], col*CellSize + CellSize/2 , row*CellSize + CellSize/2);
            }
        }
    }
}

void drawBoard(){
    fill(0);
    for (int i = 0; i <= 9 ; i++){
        if ((i % 3) == 0) { strokeWeight(3); }
        else { strokeWeight(1); }
        
        line(0,CellSize*i,BoardSize,CellSize*i);
        line(CellSize * i, 0 , i * CellSize , BoardSize);
    }
}

void fillBoard(){
    for(int row = 0 ; row < 9 ; row++){
        for(int col = 0; col < 9 ; col++){
            Board[row][col] = a[row][col];
        }
    }
}

void removeNumber(int board[][]){
    for (int row = 0 ; row < Board.length ; row++){
        int blank = int(random(2,6)); // random count for blank in 2-5
        
        for(int b = 0 ; b < blank ; b++){
            int col = int(random(9));
            while(board[row][col] == 0){ // if random in old row
                col = int(random(9)); // random again
            }
            board[row][col] = 0; 
        }
    }
}
