#!/bin/bash/
#Bash Script that takes a file of web domains and returns email addresses
clear

echo "Starting Script.";

FILE=$1;
declare -a WEBSITES;
count=0;

echo "The file given was $FILE"
echo ""

while IFS='' read -r line || [[ -n "$line" ]]; do
	WEBSITES[count]=$line #Sets the line from the file equal to an index in the array
    #WEBSITES[count]=($(whois $line | grep 'Email:')) #does not work, cant assign list to array value
    echo "Website: "$line
    whois $line | grep 'Email:'
    echo ""
    count=$(( $count + 1 ))
done < "$FILE"
# Description
# IFS='' (or IFS=) prevents leading/trailing whitespace from being trimmed.
# '-r' prevents backslash escapes from being interpreted.
# '|| [[ -n $line ]]' prevents the last line from being ignored if it doesn't end with a 
# '\n' (since read returns a non-zero exit code when it encounters EOF).


echo "Websites in $FILE"
#echo ${WEBSITES[*]}
for i in ${WEBSITES[@]}; do echo $i; done;


#echo $ARRAY[0]

echo ""
