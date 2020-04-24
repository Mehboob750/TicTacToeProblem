#!/bin/bash 
#CONSTATNTS
BOARD_SIZE=3;
BOARD_POSITION=10;
INITIAL_SYMBOL="-";
PLAYER_SYMBOL="O";
COMPUTER_SYMBOL="X";
PLAYER_TOSS=1;
COMP_TOSS=0;
opponentTurn=0;
function resetBoard(){
	echo "Welcome to Tic-Tac-Toe"
	for (( position=0; position<=$BOARD_POSITION; position++ ))
	do
        	BOARD[$position]=$INITIAL_SYMBOL;
	done
}

function checkFirst(){
	toss=$((RANDOM%2))
	if [ $toss -eq 1 ]
	then
		echo "First turn is Player"
	else
		echo "First Turn is Computer Turn"
	fi
	return $toss;
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

function checkRow(){
	position=$1;
	symbol=$2;
   if [[ ${BOARD[$position]} == ${BOARD[$position+1]} ]] && [[ ${BOARD[$position+1]} == ${BOARD[$position+2]} ]] &&  [[ ${BOARD[$position]} == $symbol ]] 
	then
		printBoard;
		if [[ $symbol == $PLAYER_SYMBOL ]]
		then
      	echo "Player Win!!!";
			opponentTurn=1;
			break;
		else
			echo "Computer Win!!!";
			opponentTurn=1;
			break;
		fi
   fi

}

function checkColumn(){
   position=$1;
   symbol=$2;
   if [[ ${BOARD[$position]} == ${BOARD[$position+3]} ]] && [[ ${BOARD[$position+3]} == ${BOARD[$position+6]} ]] && [[ ${BOARD[$position]} == $symbol ]]
   then
      printBoard;
      if [[ $symbol == $PLAYER_SYMBOL ]]
      then
         echo "Player Win!!!";
         opponentTurn=1;
			break;
      else
         echo "Computer Win!!!";
			opponentTurn=1;
         break;
      fi
   fi
}

function checkDiagonal(){
   position=$1;
   symbol=$2;
   if [[ $position == 1 ]] && [[ ${BOARD[$position]} == ${BOARD[$position+4]} ]] && [[ ${BOARD[$position+4]} == ${BOARD[$position+8]} ]] && [[ ${BOARD[$position]} == $symbol ]]
   then
      printBoard;
      if [[ $symbol == $PLAYER_SYMBOL ]]
      then
         echo "Player Win!!!";
         opponentTurn=1;
			break;
      else
         echo "Computer Win!!!";
         opponentTurn=1;
			break;
      fi
	elif [[ $position == 3 ]] && [[ ${BOARD[$position]} == ${BOARD[$position+2]} ]] && [[ ${BOARD[$position+2]} == ${BOARD[$position+4]} ]] && [[ ${BOARD[$position]} == $symbol ]]
   then
      printBoard;
      if [[ $symbol == $PLAYER_SYMBOL ]]
      then
         echo "Player Win!!!";
      	opponentTurn=1;
		   break;
      else
         echo "Computer Win!!!";
        	opponentTurn=1;
			break;
		fi
	fi
}

function  playerMove()
{
	echo "Player Turn"
	printBoard
	read -p "Enter Position : " position;
	if [ ${BOARD[$position]} == $INITIAL_SYMBOL ]
   then
		BOARD[$position]=$PLAYER_SYMBOL;
	else
		echo "Symbol is alreday present there choose different position";
		playerMove;
   fi
      toss=0;
	playerPosition=$position;
	return $position;
}

function computerMove(){
	echo "Computer Turn"
  	checkWin;
	position=$?;
	toss=1;
	return $position;
}



function checkHorizontalWin(){
      position=$1;
		symbol=$2;
		if [[ $position -gt 3 ]] && [[ $position -lt 7 ]]
      then
         position=4;
         checkRow $position $symbol;
      elif [[ $position -gt 6 ]] && [[ $position -lt 10 ]]
      then
         position=7;
         checkRow $position $symbol;
      else
         position=1;
         checkRow $position $symbol;
      fi
}

function checkColumnWin(){
	position=$1;
	symbol=$2;
	if [[ $position == 1 ]] || [[ $position == 4 ]] || [[ $position == 7 ]]
   then
      position=1;
      checkColumn $position $symbol;
   elif  [[ $position == 2 ]] || [[ $position == 5 ]] || [[ $position == 8 ]]
   then
      position=2;
      checkColumn $position $symbol;
   else
      position=3;
      checkColumn $position $symbol;
   fi
}

function checkDiagonalWin(){
   position=$1;
   symbol=$2;
   if [[ $position == 1 ]] || [[ $position == 5 ]] || [[ $position == 9 ]]
   then
      position=1;
      checkDiagonal $position $symbol;
   elif  [[ $position == 3 ]] || [[ $position == 5 ]] || [[ $position == 7 ]]
   then
      position=3;
      checkDiagonal $position $symbol;
   fi
}

function checkTie()
{
	position=1;
	while [[ ${BOARD[$position]} != $INITIAL_SYMBOL ]]
	do
		if [ $position == 9 ]
		then
				echo "Tie"
				break;
		else
				(( position++ ));
		fi
	done

}

function checkOpponentTurn(){
	if [[ $opponentTurn == 0 ]]
	then
		echo "Opponent Turn";
	fi
}

function checkCenter(){
	position=5;
	if [[ "${BOARD[$position]}" == "$INITIAL_SYMBOL" ]]
   then
		return 1;
	fi
	return 0;
}

function  checkCorner()
{
	for (( position=1; position<$BOARD_POSITION; position=$(($position+2)) ))
	do
		if [ ${BOARD[$position]} == $INITIAL_SYMBOL ]
		then
			return $position;
			break;
		fi

		if [[ $position == 3 ]]
      then
			position=$(($position+2));
		fi
	done
 return 0;
}

function checkWin(){
	checkCenter;
	true=$?;
	if [[ $true == 1 ]]
	then
		position=5;
		BOARD[$position]=$COMPUTER_SYMBOL;
	else
		if [[ "${BOARD[$playerPosition]}" == "$INITIAL_SYMBOL" ]]
		then
			BOARD[$playerPosition+1]=$COMPUTER_SYMBOL;
		else
			winningPosition;
		fi
	fi
	return $position;
}

function winningPosition(){
   if [[ ${BOARD[5]} == $COMPUTER_SYMBOL ]]
   then
      checkCorner;
      position=$?;
      BOARD[$position]=$COMPUTER_SYMBOL;
   elif [[ ${BOARD[5]} == $COMPUTER_SYMBOL ]] && [[ ${BOARD[1]} == $COMPUTER_SYMBOL ]]
   then
      if [[ ${BOARD[9]}==$INITIAL_SYMBOL ]]
      then
         position=9;
         BOARD[$position]=$COMPUTER_SYMBOL;
      fi
   elif [[ ${BOARD[9]} == $COMPUTER_SYMBOL ]] && [[ ${BOARD[5]} == $COMPUTER_SYMBOL ]]
   then
      if [[ ${BOARD[1]}==$INITIAL_SYMBOL ]]
      then
         position=1;
         BOARD[$position]=$COMPUTER_SYMBOL;
      fi
   elif [[ ${BOARD[3]} == $COMPUTER_SYMBOL ]] && [[ ${BOARD[5]} == $COMPUTER_SYMBOL ]]
   then
      if [[ ${BOARD[7]}==$INITIAL_SYMBOL ]]
      then
         position=7;
         BOARD[$position]=$COMPUTER_SYMBOL;
      fi
   elif [[ ${BOARD[7]} == $COMPUTER_SYMBOL ]] && [[ ${BOARD[5]} == $COMPUTER_SYMBOL ]]
   then
      if [[ ${BOARD[3]}==$INITIAL_SYMBOL ]]
      then
         position=3;
         BOARD[$position]=$COMPUTER_SYMBOL;
      fi
	fi
}


function playGame(){
resetBoard;
checkFirst
toss=$?;
count=1;
while [[ $opponentTurn != 1 ]]
do
	if [ $toss == $PLAYER_TOSS ]
   then
		playerMove
		position=$?;
		printBoard;
		checkHorizontalWin $position $PLAYER_SYMBOL;
		checkColumnWin $position $PLAYER_SYMBOL;
		checkDiagonalWin $position $PLAYER_SYMBOL;
		checkTie;
		checkOpponentTurn;
		toss=0;
	else
		computerMove
		position=$?;
		printBoard;
      checkHorizontalWin $position $COMPUTER_SYMBOL;
      checkColumnWin $position $COMPUTER_SYMBOL;
      checkDiagonalWin $position $COMPUTER_SYMBOL;
      checkTie;
      checkOpponentTurn;
		toss=1;
	fi
done
}
playGame;
