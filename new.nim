import os
import rdstdin
import strutils
import terminal

proc newBoard(): array[3,array[3,string]] =
    let board = [["null","null","null"],["null","null","null"],["null","null","null"]]
    return board

proc printBoard(theBoard: array[3, array[3, string]]):void =
    echo "---------"
    for i in 0..2:
        for m in 0..2:
            setForeGroundColor(fgDefault)
            stdout.write "|"
            if theBoard[i][m] == "null":
                setForeGroundColor(fgCyan)
                stdout.write "-"
            else:
                if theBoard[i][m] == "X":
                    setForeGroundColor(fgGreen)
                    stdout.write theBoard[i][m]
                    setForeGroundColor(fgDefault)
                else:
                    setForeGroundColor(fgRed)
                    stdout.write theBoard[i][m]
                    setForeGroundColor(fgDefault)
            setForeGroundColor(fgDefault)
            stdout.write "|"
            if m==2:
                echo ""
    setForeGroundColor(fgDefault)
    echo "---------"
proc isDraw(theBoard:array[3,array[3,string]]):bool =
    var occupiedCount:int = 0
    for i in 0..2:
        for f in 0..2:
            if theBoard[i][f] == "X" or theBoard[i][f] == "0":
                inc(occupiedCount)
            else:
                continue
    if occupiedCount == 9:
        return true
    else:
        return false
proc getMove():array[2,int] =
    let item1 = parseInt(readLineFromStdin "What is the first item?: ")
    let item2 = parseInt(readLineFromStdin "What is the second item?: ")
    let myArray = [item2-1,item1-1]
    return myArray
proc makeMove(theBoard:var array[3,array[3,string]],playerIcon:string):array[3, array[3,string]] =
    var moves = getMove()
    var x:int = moves[1]
    var y:int = moves[0]
    if theBoard[x][y] == "null":
        theBoard[x][y] = playerIcon
    else:
        echo "Spot Taken!"
        var theBoard = makeMove(theBoard,playerIcon)
    return theBoard
proc getPlayerTypes():array[2, string] =
    var choice1 = readLineFromStdin "Welcome to Tic-Tac-Toe!\nIs player one a cpu or a normal player(cpu/play)?: "
    var choice2 = readLineFromStdin "Is player two a cpu or a normal(cpu/play)?: "
    if (choice1 == "play" or choice1 == "cpu") and (choice2 == "play" or choice2 == "cpu"):
        var output = [choice1, choice2]
        return output
    else:
        var x = getPlayerTypes()
proc mainMenu():array[4, string] =
    var playerTypes = getPlayerTypes()
    var levels = [playerTypes[0], playerTypes[1], "null", "null"]
    if playerTypes[0] == "cpu":
        var level1 = readLineFromStdin "What level is the player1 cpu(0/1)?: "
        levels[2] = level1
    if playerTypes[1] == "cpu":
        var level2 = readLineFromStdin "What level is the player2 cpu(0/1)?: "
        levels[3] = level2
    return levels
proc lazyCpu(theBoard:var array[3, array[3,string]], playerIcon:string): array[3, array[3,string]] =
    for i in 0..2:
        for j in 0..2:
            if theBoard[i][j] == "null":
                theBoard[i][j] = playerIcon;
                sleep 1000
                return theBoard

proc main():void =
    try:
        var data = mainMenu()
        var myBoard = newBoard()
        var playerOneTurn = true
        printBoard(myBoard)
        while (true):
            if (playerOneTurn == true):
                if data[0] == "cpu" and data[2] == "0":
                    lazyCpu(myBoard, "X")
                elif data[0] == "cpu" and data[2] == "1":
                    randomCpu(myBoard, "X")
                else:
                    try:
                        makeMove(myBoard, "X")
                    except:
                        echo "The board isn't that big!"
                        makeMove(myBoard, "X")
                printBoard(myBoard)
                playerOneTurn = false
            else:
                if data[1] == "cpu" and data[3] == "0":
                    lazyCpu(myBoard, "0")
                elif data[1] == "cpu" and data[3] == "1":
                    randomCpu(myBoard, "0")
                else:
                    try:
                        makeMove(myBoard, "0")
                    except:
                        echo "The board isn't that big!"
                        makeMove(myBoard, "0")
                printBoard(myBoard)
                playerOneTurn = true
            isTrue = isFull(myBoard)
            isOver = isGameOver(myBoard)
            if isTrue:
                sleep 100
                echo "\nIt's A Tie!"
                break
            if isOver == 1:
                sleep 100
                echo "\nPlayer 2 Wins!"
                break
            elif isOver == 0:
                sleep 100
                echo "\nPlayer 1 Wins"
                break
    finally:
        againOrNo()
main()