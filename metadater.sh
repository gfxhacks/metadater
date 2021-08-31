#!/bin/bash
# Cmd Usage: sh metadater.sh file.ext kMDItemName

# Title: metadater.sh
# Desc: Rename a file from a specified date metadata value.
# Author: gfxhacks.com
# More Info: https://gfxhacks.com/renaming-files-by-date-from-metadata
# kMDItem DATE descriptor options:
	# Common Metadata Attributes:
    	# kMDItemContentCreationDate
    	# kMDItemContentModificationDate
    	# kMDItemAttributeChangeDate
    	# kMDItemLastUsedDate
    	# kMDItemDateAdded
	# Audio Metadata Attributes:
    	# kMDItemRecordingDate
	# Filesystem Metadata Attributes:
    	# kMDItemFSContentChangeDate
        # kMDItemFSCreationDate

FILEPATH=`dirname "$1"`
FILENAME=`basename "$1"`
FILEEXT=`rev <<< "$1" | cut -d . -f 1 | rev`

DATETIME=`mdls -name "$2" "$1" | sed 's/[^0-9]//g' | cut -c -12`

echo "Rename to: "
read NAME

if [[ -f "$1" ]]; then

    # copy and rename the specified file
    cp "$FILEPATH/$FILENAME" "$FILEPATH/$NAME-$DATETIME.$FILEEXT"

    # rename the specified file w/o copy
    # mv "$FILEPATH/$FILENAME" "$FILEPATH/$NAME-$DATETIME.$FILEEXT"

else
    echo "ERROR: File not found. Try again!"
fi
