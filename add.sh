#!/bin/bash
#Author: 	Caoimhín Arnott, 20104296
#Description:	Lists #####
#		Allows the user to #####

#importing the input_check function and coloured font variables
. other.sh

echo -e "\n${YELLOW}Now adding a new project.${ENDCOLOUR} \n${UNDERLINERED}Type M to return${ENDCOLOUR} to the main menu. \n${UNDERLINERED}Type Q to quit${ENDCOLOUR} out of the script."
COUNT=0
while [ $COUNT -lt 5 ]; do
	if [ $COUNT -eq 0 ]; then
		echo -e "\nWhat is the project code? \n${BOLDCYAN}Please type a three-digit number: ${ENDCOLOUR}"
		read CODE
		if input_check $CODE; then
			if [[ "$CODE" =~ ^[0-9][0-9][0-9]$ ]]; then
				COUNT=$((COUNT+1))
			else
				echo -e "${UNDERLINERED}$CODE is not a 3-digit number.${ENDCOLOUR}\n"
			fi
		fi
	fi
	if [ $COUNT -eq 1 ]; then
		echo -e "\nWhich employee is managing this project? \n${BOLDCYAN}Please type in their first name${ENDCOLOUR}"
		read NAME
		if input_check $NAME; then
			if [[ "$NAME" =~  ^[a-zA-Z]*$ ]]; then
				COUNT=$((COUNT+1))
			else
				echo -e "${UNDERLINERED}We can't accept $NAME as a first name.\nPlease only include letters, without spaces${ENDCOLOUR}\n"
			fi
		fi
	fi
	if [ $COUNT -eq 2 ]; then
		echo -e "\nWhat's the project's progress? \n${BOLDCYAN}Please type in a number from 0 - 100 to indicate what % complete the project is:${ENDCOLOUR}"
		read COMPLETION
		if input_check $COMPLETION; then
			if [[ "$COMPLETION" -ge 0 ]] && [[ "$COMPLETION" -le 100 ]]; then
				COUNT=$((COUNT+1))
			else
				echo -e "${UNDERLINERED}$COMPLETION is not a number from 0 to 100${ENDCOLOUR}\n"
			fi
		fi
	fi
	if [ $COUNT -eq 3 ]; then
		echo -e "\nWhich client contracted this project? \n${BOLDCYAN}Please type in their company name:${ENDCOLOUR}"
		read CLIENT
		if input_check $CLIENT; then
			if [[ "$CLIENT" =~  ^[a-zA-Z]*$ ]]; then
				COUNT=$((COUNT+1))
			else
				echo -e "${UNDERLINERED}We can't accept $CLIENT; please only include letters, without spaces${ENDCOLOUR}\n"
			fi
		fi
	fi
	while [ $COUNT -eq 4 ]; do
		echo -e "\nWhat is the client's contact number? \n${BOLDCYAN}Please type a ten-digit number${ENDCOLOUR} (no spaces or hyphens):"
		read PHONE
		if input_check $PHONE; then
			if [[ "$PHONE" =~ ^[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]$ ]]; then
				echo -e "\n  ${MAGENTA}Project: $CODE\n  Manager: $NAME\n  Progress: $COMPLETION%\n  Client: $CLIENT\n  Contact: $PHONE${ENDCOLOUR}"
				echo -e "\n${BOLDCYAN}Would you like to add this project? (Y/N)${ENDCOLOUR}"
				read PROCEED
				if [[ "$PROCEED" =~ [yY] ]]; then
					echo $CODE" "$NAME" "$COMPLETION" "$CLIENT" "$PHONE >> proj.txt
					echo -e "${YELLOW}\nSuccessfully added new project\nReturning to Main Menu${ENDCOLOUR}"
				else
					echo -e "${UNDERLINERED}\nProject not added\nReturning to Main Menu${ENDCOLOUR}"
				fi
				COUNT=$((COUNT+1))
			else
				echo -e "${UNDERLINERED}$PHONE is not a ten-digit number${ENDCOLOUR}\n"
			fi
		fi
	done
done
