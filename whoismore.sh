#!/bin/bash/


#Bash Script that takes a file of web domains and returns email addresses

echo "Starting Script."
echo ""

FILE=$1

echo "The file given was $FILE"

while IFS='' read -r line || [[ -n "$line" ]]; do
	echo $line
    whois $line | grep 'Email:'
done < "$FILE"


# Description
# IFS='' (or IFS=) prevents leading/trailing whitespace from being trimmed.
# '-r' prevents backslash escapes from being interpreted.
# '|| [[ -n $line ]]' prevents the last line from being ignored if it doesn't end with a 
# '\n' (since read returns a non-zero exit code when it encounters EOF).


#echo $ARRAY[0]





echo ""


