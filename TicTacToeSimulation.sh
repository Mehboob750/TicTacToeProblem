#!/bin/bash -x
#CONSTATNTS
BOARD_SIZE=3;
BOARD_POSITION=10;
INITIAL_SYMBOL="-";
echo "Welcome to Tic-Tac-Toe"
for (( position=0; position<=$BOARD_POSITION; position++ ))
do
        BOARD[$position]=$INITIAL_SYMBOL;
done
