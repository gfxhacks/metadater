#!/bin/bash

# Cmd Usage: sh metadater.sh file.ext

# Title: metadater.sh
# Version: 1.0.0
# Desc: Rename a file from a specified date metadata value.
# Author: gfxhacks.com
# More Info: https://gfxhacks.com/renaming-files-by-date-from-metadata

FILEPATH=`dirname "$1"`
FILENAME=`basename "$1"`
FILEEXT=`rev <<< "$1" | cut -d . -f 1 | rev`

printf "Rename to: "
read NAME
printf "\nChoose Date Format: \n1:YYMMDDhhmmss\n2:YYMMDDhhmm\n3:YYMMDD\n"
read DATEFORMAT
printf "\nChoose Date Type: \n1:Creation Date\n2:Modification Date\n3:Date Added\n"
read KMDDATENAME

# select date format
if [[ $DATEFORMAT == 1 ]]; then
  DATESLICE="3-14"
elif [[ $DATEFORMAT == 2 ]]; then
  DATESLICE="3-12"
elif [[ $DATEFORMAT == 3 ]]; then
  DATESLICE="3-8"
else
  DATESLICE="3-14"
fi

# select kMDItem date
if [[ $KMDDATENAME == 1 ]]; then
  KMDDATENAME="kMDItemContentCreationDate"
elif [[ $KMDDATENAME == 2 ]]; then
  KMDDATENAME="kMDItemContentModificationDate"
elif [[ $KMDDATENAME == 3 ]]; then
  KMDDATENAME="kMDItemDateAdded"
else
  KMDDATENAME="kMDItemContentCreationDate"
fi

# get date and conform to specified format
DATETIME=`mdls -name $KMDDATENAME "$1" | sed 's/[^0-9]//g' | cut -c $DATESLICE`

if [[ -f "$1" ]]; then

    # copy and rename the specified file
    # cp "$FILEPATH/$FILENAME" "$FILEPATH/$NAME-$DATETIME.$FILEEXT"
    # rename the specified file w/o copy
    mv "$FILEPATH/$FILENAME" "$FILEPATH/$NAME-$DATETIME.$FILEEXT"
    printf "\nFile renamed to: $NAME-$DATETIME.$FILEEXT\n\n"

else
    printf "\nERROR: File not found. Try again!\n"
fi
