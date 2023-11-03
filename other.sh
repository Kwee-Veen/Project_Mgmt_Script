#!/bin/bash
#Author: 	Caoimhín Arnott, 20104296
#Description:	Contains functions and variables that all other scripts inherit

#Setting colour & format fonts as variables:
YELLOW="\e[93m"
MAGENTA="\e[35m"
CYAN="\e[36m"
UNDERLINEYELLOW="\e[4;93m"
UNDERLINEMAGENTA="\e[4;35m"
UNDERLINERED="\e[4;31m"
BOLDCYAN="\e[1;36m"
ENDCOLOUR="\e[0m"

# This function runs a general check on the user input. Blank input returns a 1, which causes downstream if statements to loop, requesting new user input.
# M exits to the main menu with exit code 0, and Q quits the script entirely using exit code 1, as any non-zero exit code will terminate the main script
input_check () {
	if [[ $1 =~ ^[qQ]+$ ]]; then
		echo -e "${MAGENTA}Exiting"
		echo -e "________________________________${ENDCOLOUR}\n"
		exit 1
	elif [[ $1 =~ ^[mM]+$ ]]; then
		echo -e "${YELLOW}Returning to the Main Menu${ENDCOLOUR}\n"
		exit 0
	elif [ -z $1 ]; then
		echo -e "${UNDERLINERED}Blank input. Please try again${ENDCOLOUR}"
		return 1
	fi
}

#Formats text properly for when an overview of current projects is called in various scripts
project_overview () {
	if [[ $1 == "u" ]]; then
		echo -e "\n${YELLOW}________________________________${ENDCOLOUR}"
	fi
	echo -e "\n${MAGENTA}Overview${ENDCOLOUR}"
	echo -e "${YELLOW}Project  Manager       Progress  Client       Phone${ENDCOLOUR}"
	awk '/^[0-9]/{printf("%-8s %-12s %-9s %-12s %s\n",$1,$2,$3"%",$4,$5)}' proj.txt
}

duplicate_check () {
	sort proj.txt | uniq -d
}

#Sets the format correctly for uses of awk
awk_command () {
	awk '/^[0-9]/{printf("%-8s %-12s %-9s %-12s %s\n",$1,$2,$3"%",$4,$5)}'
}

#Formats text properly for when a search of current projects is called in various scripts
output_text () {
	if [[ $1 == "h" ]]; then
		echo -e "${YELLOW}Project  Manager      Progress  Client       Phone${ENDCOLOUR}"
	elif [[ $1 == "u" ]]; then
		echo -e "\n${YELLOW}________________________________${ENDCOLOUR}"
		echo -e "\n${YELLOW}Searching prompt ${ENDCOLOUR}${BOLDCYAN}$PROMPT${ENDCOLOUR}"
		HITS=`grep -c "$PROMPT" proj.txt`
		if [[ $HITS == 0 ]]; then
			echo -e "${UNDERLINERED}Zero matching projects${ENDCOLOUR}"
		else
			echo -e "${MAGENTA}$HITS${ENDCOLOUR} ${YELLOW}matching project(s) found:${ENDCOLOUR}\n"
			echo -e "${YELLOW}Project  Manager      Progress  Client       Phone${ENDCOLOUR}"
			echo -e "${MAGENTA}$COMMAND${ENDCOLOUR}"
		fi
	else
		echo -e "\n${YELLOW}Searching prompt ${ENDCOLOUR}${BOLDCYAN}$PROMPT${ENDCOLOUR}"
		HITS=`grep -c "$PROMPT" proj.txt`
		if [[ $HITS == 0 ]]; then
			echo -e "${UNDERLINERED}Zero matching projects${ENDCOLOUR}"
		else
			echo -e "${MAGENTA}$HITS${ENDCOLOUR} ${YELLOW}matching project(s) found:${ENDCOLOUR}\n"
			echo -e "${YELLOW}Project  Manager      Progress  Client       Phone${ENDCOLOUR}"
			echo -e "${MAGENTA}$COMMAND${ENDCOLOUR}"
		fi
	fi
}
