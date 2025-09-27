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

int rows , cols = -1;

        
void setup(){
    size(450,550);
    textAlign(CENTER, CENTER);
    textSize(30);
    
    fillBoard();
    removeNumber(Board);
    printBoardTest();
    
    drawBoard();
    drawNumberInBoard();
    drawAnswer();
}

void draw(){
    background(250);
    
    if(rows >= 0 && cols >= 0){
        selectedCell();
    }
    
    drawBoard();
    drawNumberInBoard();
    drawAnswer();
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

void drawAnswer(){
    fill(0);
    
    strokeWeight(3);
    //draw line for answer cell
    line(0 , CellSize * 10,width , CellSize * 10);
    line(0 , CellSize * 11,width , CellSize * 11);
    for(int i = 0 ; i < 9 ; i++){
        line(CellSize * i ,CellSize * 10 ,CellSize * i ,CellSize * 11 );
    }
    
    //draw number to answer in cell
    for (int col = 0 ; col < 9 ;col++){
        textAlign(CENTER, CENTER);
        textSize(30);
        text(col+1 , col*CellSize + CellSize/2 , CellSize * 10.5);
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

void selectedCell(){
    fill(255, 255, 0, 150); //yellow colour
    noStroke();
    rect(cols * CellSize, rows * CellSize, CellSize, CellSize);
    
    //draw stroke for grid of board
    stroke(0);
    strokeWeight(1);
    noFill();
    rect(cols * CellSize, rows * CellSize, CellSize, CellSize);

}
