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

function  playerMove(){
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
   if [[ $position == 1 ]] || [[ $position == 9 ]]
   then
      position=1;
      checkDiagonal $position $symbol;
   elif [[ $position == 3 ]] || [[ $position == 5 ]] || [[ $position == 7 ]]
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
	if [[ ${BOARD[$position]} == $INITIAL_SYMBOL ]]
   then
		return 1;
	fi
	return 0;
}

function  checkCorner()
{
	for (( position=1; position<$BOARD_POSITION; position=$(($position+2)) ))
	do
		if [[ "${BOARD[$position]}" == "$INITIAL_SYMBOL" ]]
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

function myWin(){
   if [[ ${BOARD[$myPosition]} == ${BOARD[$myPosition+1]} ]]
   then
      BOARD[$myPosition-1]=$COMPUTER_SYMBOL;
      return 1;
   elif [[ ${BOARD[$myPosition]} == ${BOARD[$myPosition-1]} ]]
   then
      BOARD[$myPosition+1]=$COMPUTER_SYMBOL;
      return 1;
   elif [[ ${BOARD[$myPosition]} == ${BOARD[$myPosition+3]} ]]
   then
       BOARD[$myPosition+6]=$COMPUTER_SYMBOL;
       return 1;
   elif [[ ${BOARD[$myPosition]} == ${BOARD[$myPosition+6]} ]]
   then
       BOARD[$myPosition+3]=$COMPUTER_SYMBOL;
       return 1;
    elif [[ ${BOARD[$myPosition]} == ${BOARD[$myPosition-6]} ]]
    then
       BOARD[$myPosition-3]=$COMPUTER_SYMBOL;
       return 1;
    elif [[ ${BOARD[$myPosition]} == ${BOARD[$myPosition-3]} ]]
    then
       BOARD[$myPosition-6]=$COMPUTER_SYMBOL;
       return 1;
   fi
return 0;
}

function opponentBlock(){
		if [[ ${BOARD[$playerPosition]} == ${BOARD[$playerPosition+1]} ]]
		then
			BOARD[$playerPosition-1]=$COMPUTER_SYMBOL;
			return 1;
 		elif [[ ${BOARD[$playerPosition]} == ${BOARD[$playerPosition+2]} ]]
      then
         BOARD[$playerPosition+1]=$COMPUTER_SYMBOL;
			return 1;
		elif [[ ${BOARD[$playerPosition]} == ${BOARD[$playerPosition-3]} ]]
      then
         BOARD[$playerPosition+3]=$COMPUTER_SYMBOL;
         return 1;
		elif [[ ${BOARD[$playerPosition]} == ${BOARD[$playerPosition-2]} ]]
      then
         BOARD[$playerPosition-1]=$COMPUTER_SYMBOL;
         return 1;

		elif [[ ${BOARD[$playerPosition]} == ${BOARD[$playerPosition-1]} ]]
		then
			BOARD[$playerPosition+1]=$COMPUTER_SYMBOL;
			return 1;
		elif [[ ${BOARD[$playerPosition]} == ${BOARD[$playerPosition+3]} ]]
		then
			 BOARD[$playerPosition+6]=$COMPUTER_SYMBOL;
		 	return 1;
		elif [[ ${BOARD[$playerPosition]} == ${BOARD[$playerPosition+6]} ]]
   	then
	    	BOARD[$playerPosition+3]=$COMPUTER_SYMBOL;
		 	return 1;
	 	elif [[ ${BOARD[$playerPosition]} == ${BOARD[$playerPosition-6]} ]]
    	then
       	BOARD[$playerPosition-3]=$COMPUTER_SYMBOL;
       	return 1;
	 	elif [[ ${BOARD[$playerPosition]} == ${BOARD[$playerPosition-3]} ]]
    	then
       	BOARD[$playerPosition-6]=$COMPUTER_SYMBOL;
       	return 1;
		else
			return 0;
		fi
}

function compWin(){
	if [[ ${BOARD[$myPosition]} == ${BOARD[$myPosition-3]} ]]
   then
   	BOARD[$myPosition+3]=$COMPUTER_SYMBOL;
      return 1;
 	elif [[ ${BOARD[$myPosition]} == ${BOARD[$myPosition+3]} ]]
   then
      BOARD[$myPosition+6]=$COMPUTER_SYMBOL;
      return 1;
	else
		return 0;
	fi
}

function computerMove(){
	checkCenter;
	true=$?;
	if [[ $true == 1 ]]
	then
		position=5;
		BOARD[$position]=$COMPUTER_SYMBOL;
	else
		compWin;
		correct1=$?;
	fi

	if [[ $correct1 == 0 ]]
   then
   	opponentBlock;
      correct=$?;
   fi

	if [[ $correct == 0 ]]
	then
		BOARD[$position+1]=$COMPUTER_SYMBOL;
	fi
	toss=1;
	myPosition=$position;
return $position;
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
if [[ $opponentTurn == 1 ]]
then
	echo "Game Over"
	break;
fi
}
playGame;
