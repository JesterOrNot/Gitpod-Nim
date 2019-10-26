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
                stdout.write theBoard[i][m]
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
var board = newBoard()
printBoard(board)
board = makeMove(board,"X")
printBoard(board)