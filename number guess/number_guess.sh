#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

echo "Enter your username:"
read NAME_INPUT
USERNAME=$($PSQL "SELECT name FROM players WHERE name = '$NAME_INPUT'")

# if name does not exist in database, add to database
if [[ -z $USERNAME ]]
then
  echo -e "\nWelcome, $NAME_INPUT! It looks like this is your first time here."
else
  # read and print player stats
  GAMES_PLAYED=$($PSQL "SELECT games FROM players WHERE name = '$NAME_INPUT'")
  BEST_GAME=$($PSQL "SELECT best_guess FROM players WHERE name = '$NAME_INPUT'")

  # display stats for player
  echo -e "\nWelcome back, $(echo $USERNAME | sed -r 's/^ *| *$//g')! You have played $(echo $GAMES_PLAYED | sed -r 's/^ *| *$//g') games, and your best game took $(echo $BEST_GAME | sed -r 's/^ *| *$//g') guesses."
fi

# generate random number
NUMBER=$((RANDOM%1000+1))
ATTEMPT=1
# echo $NUMBER  # cheat the game
# number game start
echo -e "\nGuess the secret number between 1 and 1000:"

SAVE_STAT(){
# check if new player
if [[ -z $USERNAME ]]
then
  # save stat to database if new player
  INSERT_PLAYER_RESULT=$($PSQL "INSERT INTO players(name, games, best_guess) VALUES('$NAME_INPUT', 1, $ATTEMPT);")
else
  # for returnees, increment total games played
  INCREMENT_GAMES_PLAYED=$($PSQL "UPDATE players SET games = games+1 WHERE name = '$NAME_INPUT';")

  # compare current game record to database and rewrite accordingly
  if (( $BEST_GAME > $ATTEMPT ))
  then
    INSERT_NEW_RECORD=$($PSQL "UPDATE players SET best_guess = $ATTEMPT WHERE name = '$NAME_INPUT';")
  fi
fi
#echo "Game is saving..."
#echo "Thank you for playing."
}

GUESS_GAME(){
  if [[ $1 ]]
  then
    echo -e "$1"
  fi

  read GUESS

  # if guess is not an integer, redo
    # if [[ ! $GUESS == ?(-)+([0-9]) ]] # alternatively this checks for integer
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    # send to main menu
    GUESS_GAME "That is not an integer, guess again:"
  fi

  # check number for guessing game
  if [[ $NUMBER -lt $GUESS ]]
  then
    # guess is bigger, retry
    ((ATTEMPT++))
    GUESS_GAME "It's lower than that, guess again:"
  elif (( $NUMBER > $GUESS ))
  then
    # guess if smaller, retry
    ((ATTEMPT++))
    GUESS_GAME "It's higher than that, guess again:"
  else
    # you wonnnnn
    echo -e "\nYou guessed it in $ATTEMPT tries. The secret number was $NUMBER. Nice job!"
    SAVE_STAT
  fi

}

GUESS_GAME
