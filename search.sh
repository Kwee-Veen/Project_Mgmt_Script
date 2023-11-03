#!/bin/bash
#Author: 	Caoimhín Arnott, 20104296
#Description:	Allows the user to search for projects matching their input, with sub-functions for further customisability

# Importing supporting functions and coloured font variables
. other.sh

# Setting sub-functions to provide options to disable case sensitivity or run term exclusion searches
case_check () {
	echo -e "\nBy default your search will be case insensitive."
	echo -e "${BOLDCYAN}Would you prefer to make your input case sensitive? (Y/N)${ENDCOLOUR}"
	PS3="Type D or E: "
	read SENSITIVITY
	if input_check $SENSITIVITY; then
		if [[ "$SENSITIVITY" =~ ^[yY]$ ]]; then
			echo "Input will be case sensitive"
			return 0
		else
			echo "Input will not be case sensitive"
			return 1
		fi
	fi
}

exclude_check () {
	echo -e "\nBy default we will search for your input."
	echo -e "${BOLDCYAN}Would you prefer to exclude your input from search results? (Y/N)${ENDCOLOUR}"
	PS3="Type F or E: "
	read INCLUDE
	if input_check $INCLUDE; then
		if [[ $INCLUDE =~ ^[yY]+$ ]]; then
			echo "Input will be excluded from search"
			return 0
		else
			echo "Will search for your input exclusively"
			return 1
		fi
	fi
}

echo -e "\n${YELLOW}Project search menu.${ENDCOLOUR}"
echo -e "You can ${UNDERLINERED}type M to return${ENDCOLOUR} to the main menu, or ${UNDERLINERED}type Q to quit${ENDCOLOUR}"

# Search prompts are read in here; numerous prompts can be saved
PROMPTS=()
PS3="Your search prompt: "
while true; do
	echo -e "\n${BOLDCYAN}Please type in your search prompt:${ENDCOLOUR}"
	read SEARCH
	if input_check $SEARCH; then
		PROMPTS+=" $SEARCH"
	fi
	echo -e "\nAdded. ${BOLDCYAN}Add another search prompt? (Y/N)${ENDCOLOUR}"
	read REPEATCHECK
	if input_check $REPEATCHECK; then
		if [[ "$REPEATCHECK" =~ ^[yY]$ ]]; then
			continue
		else
			break
		fi
	fi
done

# Search prompts are searched after the user specifies which search modes they would like to run
if case_check; then
	if exclude_check; then
		for PROMPT in $PROMPTS; do
			COMMAND=`grep -v "$PROMPT" proj.txt | awk_command`
			output_text u
		done
	else
		for PROMPT in $PROMPTS; do
			COMMAND=`grep "$PROMPT" proj.txt | awk_command`
			output_text u
		done
	fi
else
	if exclude_check; then
		for PROMPT in $PROMPTS; do
			COMMAND=`grep -v -i "$PROMPT" proj.txt | awk_command`
			output_text u
		done
	else
		for PROMPT in $PROMPTS; do
			COMMAND=`grep -i "$PROMPT" proj.txt | awk_command`
			output_text u
		done
	fi
fi
