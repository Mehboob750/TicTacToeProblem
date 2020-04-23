#!/bin/bash -x
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

toss=$((RANDOM%2))
if [ $toss -eq 1 ]
then
	echo "First turn is Player"
else
	echo "First Turn is Computer Turn"
fi
