#!/bin/bash
#Author: 	Caoimhín Arnott, 20104296
#Description:	Script allowing for the deletion of projects, with a separate functionality for deleting duplicate projects

# Importing shared functions and coloured font variables
. other.sh

echo -e "\n${YELLOW}Project deletion menu.${ENDCOLOUR}"
echo -e "${UNDERLINERED}Type M to return${ENDCOLOUR} to the main menu.\n${UNDERLINERED}Type Q to quit${ENDCOLOUR} out of the script."
echo -e "\n${BOLDCYAN}Type D to search for duplicate projects, or any other key for the regular deletion menu:${ENDCOLOUR}"

# Checks if user wants to delete duplicate projects or run the main project deletion prompt
while true; do
	read DUPECHECK
	if input_check $DUPECHECK; then
		break
	fi
done

# Duplicate project deletion
if [[ "$DUPECHECK" =~ ^[dD] ]]; then
	echo ""
	DUPLICATES=`duplicate_check`
	if [[ "$DUPLICATES" == "" ]]; then
		echo -e "${UNDERLINERED}No duplicates found${ENDCOLOUR}"
	else
		output_text h
		duplicate_check | awk_command
		LINES=`echo -e "$DUPLICATES" | wc -l`
		ITERATIONS="$LINES"
		i="1"
		while [ $i -le $ITERATIONS ]; do
			DUPE=`echo -e "$DUPLICATES" | awk -v row="$i" 'NR==row{print $0}'`
			echo -e "\n${YELLOW}Duplicate number $i:${ENDCOLOUR} ${BOLDCYAN}Delete $DUPE? (Y/N)${ENDCOLOUR}"
			while true; do
				read CONFIRM
				if input_check $CONFIRM; then
					break
				fi
			done
			if [[ "$CONFIRM" =~ ^[yY] ]]; then
				sed -i "/$DUPE/d" proj.txt
				echo -e "$DUPE" >> proj.txt
				echo -e "\n${MAGENTA}Deletion successful${ENDCOLOUR}"
			else
				echo -e "\n${UNDERLINERED}Skipping this duplicate${ENDCOLOUR}"
			fi
			i=$((i+1))
		done
	fi
else
# Main project deletion prompt

	project_overview
	echo -e "\n${BOLDCYAN}Which project(s) would you like to delete?${ENDCOLOUR}"
	PROMPTS=()
	PS3="Your deletion prompt: "
	while true; do
		echo -e "\n${BOLDCYAN}Please type in your deletion prompt:${ENDCOLOUR}"
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
	for PROMPT in $PROMPTS; do
		if cat proj.txt | grep -q -i "$PROMPT"; then
			COMMAND=`grep -i "$PROMPT" proj.txt | awk_command`
			output_text
			echo -e "\n${BOLDCYAN}Delete this project? (Y/N)${ENDCOLOUR}"
			while true; do
				read CONFIRM
				if input_check $CONFIRM; then
					break
				fi
			done
			if [[ "$CONFIRM" =~ ^[yY] ]]; then
				sed -i "/$PROMPT/d" proj.txt
				echo -e "${MAGENTA}Project deleted successfully${ENDCOLOUR}"
			else
				echo -e "${UNDERLINERED}Cancelled - returning to main menu${ENDCOLOUR}"
			fi
		else
			echo -e "\n${UNDERLINERED}$PROMPT did not match any projects.${ENDCOLOUR}"
		fi
	done
fi
