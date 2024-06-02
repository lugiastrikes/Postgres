#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# if no argument was entered when running script
if [[ ! $1 ]]
then
  # give error
  echo "Please provide an element as an argument."
else
  # find argument in elements table, checking for numeric
  if [[ $1 =~ ^[0-9]+$ ]]
  then
  # atomic number
    INPUT=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = '$1'")
    if [[ -z $INPUT ]]
    then
      echo "I could not find that element in the database."
    # else if atom number exists, read out info in properties table
    else
    ATOM_NO=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = '$1'")
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = '$1'")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = '$1'")
    METAL_TYPE=$($PSQL "SELECT type FROM properties JOIN types ON properties.type_id = types.type_id where atomic_number = '$1'")
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = '$1'")
    MELTING_PT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = '$1'")
    BOILING_PT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = '$1'")
    # print info
    echo "The element with atomic number $ATOM_NO is $NAME ($SYMBOL). It's a $METAL_TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_PT celsius and a boiling point of $BOILING_PT celsius."
    fi
  else
  # not numeric, assuming alphabet
  # symbol
    INPUT=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'")
    if [[ -z $INPUT ]]
    then
      # name
      INPUT=$($PSQL "SELECT name FROM elements WHERE name = '$1'")
      if [[ -z $INPUT ]]
      then
        echo "I could not find that element in the database."
      # else if name exists, read out info in properties table
      else
        ATOM_NO=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
        NAME=$($PSQL "SELECT name FROM elements WHERE name = '$1'")
        SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$1'")
        METAL_TYPE=$($PSQL "SELECT type FROM properties JOIN types ON properties.type_id = types.type_id where atomic_number = $ATOM_NO")
        MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOM_NO")
        MELTING_PT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOM_NO")
        BOILING_PT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOM_NO")
        # print info
        echo "The element with atomic number $ATOM_NO is $NAME ($SYMBOL). It's a $METAL_TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_PT celsius and a boiling point of $BOILING_PT celsius."
      fi
    # else if symbol exists, read out info in properties table
    else
    ATOM_NO=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
    NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$1'")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'")
    METAL_TYPE=$($PSQL "SELECT type FROM properties JOIN types ON properties.type_id = types.type_id where atomic_number = $ATOM_NO")
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOM_NO")
    MELTING_PT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOM_NO")
    BOILING_PT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOM_NO")
    # print info
    echo "The element with atomic number $ATOM_NO is $NAME ($SYMBOL). It's a $METAL_TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_PT celsius and a boiling point of $BOILING_PT celsius."
    fi
  fi
fi


