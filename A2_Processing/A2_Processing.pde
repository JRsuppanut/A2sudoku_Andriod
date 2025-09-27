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
boolean FixedNumber[][] = new boolean[9][9]; // stack number is not to play

int CellSize = 50;
int BoardSize = 9 * CellSize;
int Blank[] = new int[4];//invisible cols    

int rows , cols = -1; // currennt cell selected
int DraggingAnswer = -1; // -1 for nothing

boolean IsComplete = false;
        
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
    
    //not used for andriod
    //if(rows >= 0 && cols >= 0){
    //    selectedCell();
    //}
    
    drawBoard();
    drawNumberInBoard();
    drawAnswer();
    
    //draw dragging answer
    if(DraggingAnswer != -1){
        text(DraggingAnswer , mouseX , mouseY);
        strokeWeight(2);
        line(mouseX -25 , mouseY-25 , mouseX+25 , mouseY-25);
        line(mouseX -25 , mouseY+25 , mouseX+25 , mouseY+25);
        line(mouseX -25 , mouseY-25 , mouseX-25 , mouseY+25);
        line(mouseX +25 , mouseY-25 , mouseX+25 , mouseY+25);
    }
    
}

void mouseClicked(){
    //check current cell
    if(mouseY <= 450){
        rows = mouseY / CellSize;
        cols = mouseX / CellSize;
    }
    println("(" + rows + ", " + cols + ")");
    
}

void mousePressed(){
    //drop the answer
    if(mouseY > CellSize*10){
        int col = mouseX / CellSize;
        DraggingAnswer = col + 1;
    }
    
}

void mouseReleased(){
    if(DraggingAnswer != -1){
        int row = mouseY / CellSize;
        int col = mouseX / CellSize;
        
        if(row < 9 && col < 9 && !FixedNumber[row][col]){
            Board[row][col] = DraggingAnswer;
        }
        
        for(int i = 0 ; i < 9 ; i++){
            
        }
        
        //reset Dragging Number
        DraggingAnswer = -1; 
    }
    
    //** if game is COMPLETE **
    if(!IsComplete){
        background(155);
        noLoop();
        textSize(50);
        text("You win!" , width/2 , height/2);
    }
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
                if(FixedNumber[row][col]){ //if it's not player
                    fill(0);
                }
                else if (isDuplicate(row , col , Board[row][col])){
                    fill(200,0,0);
                }
                else if (!FixedNumber[row][col]){// if it's player
                    fill(0,200,100);
                }
                else{
                    fill(0,200,100);
                }
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
        
        //player need to fix
        for(int b = 0 ; b < blank ; b++){
            int col = int(random(9));
            while(board[row][col] == 0){ // if random in old row
                col = int(random(9)); // random again
            }
            board[row][col] = 0; 
            FixedNumber[row][col] = false;
        }
        //player dont need to fix
        for(int col = 0 ; col < 9 ;col++){
            if(board[row][col] != 0){
                FixedNumber[row][col] = true;
            }
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

boolean isDuplicate(int ThatRow , int ThatCol , int answer){
    //check in row BUT not itself
    for(int j = 0 ; j < 9 ; j++){
        if( (j != ThatCol) && (Board[ThatRow][j] == answer) ) return true;
    }
    //check in colum BUT not itself
    for(int i = 0 ; i < 9 ; i++){
        if( (i != ThatRow) && (Board[i][ThatCol] == answer) ) return true;
    }
    //check in 3*3
    int StartRow = (ThatRow / 3) * 3;
    int StartCol = (ThatCol / 3) * 3;
    //check in colum BUT not itself
    for(int i = StartRow ; i < StartRow+3 ; i++){
        for(int j = StartCol; j < StartCol +3; j++){
            if( (i != ThatRow || j != ThatCol) && (Board[i][j] == answer) ) return true;
        }
    }
    return false;
}

void isGameComplete(){
    // if not fill all and uncomplete
    for (int row = 0; row < 9 ; row++){
        for (int col = 0 ; col < 9 ; col++){
            if(Board[row][col] == 0 || isDuplicate(row , col , Board[row][col])) IsComplete = false;
        }
    }
    //complete
    IsComplete = true;
}

void restart(){
    IsComplete = false;
    fillBoard();
    removeNumber(Board);
    rows = -1;
    cols = -1;
    loop();
}
