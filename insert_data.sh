#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "truncate teams, games;")

#inserting into teams table
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $WINNER != winner ]]
  then
    #get teamid from winner
    TEAM_ID=$($PSQL "SELECT team_id from teams WHERE name='$WINNER'")
    #if not found
    if [[ -z $TEAM_ID ]]
    then
      #insert team
      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      if [[ $INSERT_TEAM_RESULT == 'INSERT 0 1' ]]
      then
        echo Inserted into teams, $WINNER
      fi
      # get new teamid
      TEAM_ID=$($PSQL "SELECT team_id from teams WHERE name='$WINNER'")
    fi
  fi

  if [[ $OPPONENT != opponent ]]
  then
    #get teamid from opponent
    TEAM_ID=$($PSQL "SELECT team_id from teams WHERE name='$OPPONENT'")
    #if not found
    if [[ -z $TEAM_ID ]]
    then
      #insert team
      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      if [[ $INSERT_TEAM_RESULT == 'INSERT 0 1' ]]
      then
        echo Inserted into teams, $OPPONENT
      fi
      # get new teamid
      TEAM_ID=$($PSQL "SELECT team_id from teams WHERE name='$OPPONENT'")
    fi
  fi
done

# inserting into games table
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then
    #get winner id
    WINNER_ID=$($PSQL "SELECT team_id from teams WHERE name='$WINNER'")
    #get opponent id
    OPPONENT_ID=$($PSQL "SELECT team_id from teams WHERE name='$OPPONENT'")
  fi

  #insert match
  INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES('$YEAR', '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
  if [[ $INSERT_GAME_RESULT == 'INSERT 0 1' ]]
  then
    echo Inserted into games, $YEAR $ROUND: $WINNER $OPPONENT $WINNER_GOALS-$OPPONENT_GOALS
  fi 
done
