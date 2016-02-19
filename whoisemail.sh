#!/bin/bash/
#Bash Script that takes a file of web domains and returns email addresses to console
#Also takes just a website

clear

echo "Starting Script..";
echo ""

fflag=false
wflag=false
hflag=false

while true; do
  case "$1" in
    -f | --file ) fflag=true; FILE=$2; shift ;;
	-w | --website ) wflag=true; WEBSITE=$2; shift ;;
	-h | --help ) hflag=true; shift ;;
	* ) break ;;
  esac
done

if ${fflag}; then
	declare -a WEBSITES;
	count=0;
	echo "The file given: $FILE"
	echo ""

	while IFS='' read -r line || [[ -n "$line" ]]; do
		WEBSITES[count]=$line #Sets the line from the file equal to an index in the array
		#WEBSITES[count]=($(whois $line | grep 'Email:')) #does not work, can't assign list to array value
		echo "Website: '$line', Website email addresses:"
		whois $line | grep 'Email:'
		echo ""
		count=$(( $count + 1 ))
	done < "$FILE";

	echo "Websites in $FILE:"

	for i in ${WEBSITES[@]}; do echo $i; done;

elif ${wflag}; then
	echo "Website: '$WEBSITE', Website email addresses:"
	whois $WEBSITE | grep 'Email:'
elif ${hflag};then
	echo "Help is on the way."
	echo "Parameters for this program:"
	printf " -f, -h, -w\n"
	printf "Only give one parameter when running the program.\n"
	printf "\t -h --help\n"
	printf "\t\t 'bash whoisemail.sh -h'\n"
	printf "\t\t Produces this page. Gives a list of help on all the functions.\n"
	printf "\t -f --file\n"
	printf "\t\t 'bash whoisemail.sh -f sample.txt'\n"
	printf "\t\t -f takes a text file as the second parameter when the '-f' flag is raised.\n"
	printf "\t -w --website\n"
	printf "\t\t 'bash whoisemail.sh -w example.com'\n"
	printf "\t\t -w takes domain/website as the second parameter when the '-w' flag is raised\n"
else
	echo "No parameters given:"
	echo "Try running 'bash whoisemail.sh -h' for help."
fi

# Description for lines ~ 27-34
# IFS='' (or IFS=) prevents leading/trailing whitespace from being trimmed.
# '-r' prevents backslash escapes from being interpreted.
# '|| [[ -n $line ]]' prevents the last line from being ignored if it doesn't end with a 
# '\n' (since read returns a non-zero exit code when it encounters EOF).

echo ""
