#!/bin/bash 
#CONSTATNTS
BOARD_SIZE=3;
BOARD_POSITION=10;
INITIAL_SYMBOL="-";
PLAYER_SYMBOL="O";
COMPUTER_SYMBOL="X";

function resetBoard(){
	echo "Welcome to Tic-Tac-Toe"
	for (( position=0; position<=$BOARD_POSITION; position++ ))
	do
        	BOARD[$position]=$INITIAL_SYMBOL;
	done
}

function toss(){
	toss=$((RANDOM%2))
	if [ $toss -eq 1 ]
	then
		echo "First turn is Player"
	else
		echo "First Turn is Computer Turn"
	fi
}

function printBoard(){
	echo "-------------";
	echo "| ${BOARD[1]} | ${BOARD[2]} | ${BOARD[3]} | ";
	echo "-------------";
	echo "| ${BOARD[4]} | ${BOARD[5]} | ${BOARD[6]} | ";
	echo "-------------";
	echo "| ${BOARD[7]} | ${BOARD[8]} | ${BOARD[9]} | ";
	echo "-------------";
}
resetBoard;
printBoard;
