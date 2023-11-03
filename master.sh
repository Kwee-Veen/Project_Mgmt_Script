#!/bin/bash
#Author: 	Caoimhín Arnott, 20104296
#Description:	Master script which calls all uses all other scripts. Bash into this file to begin.

#Importing input_check function and coloured font variables:
. other.sh

# If the user inputs Q within any of the subscripts, it will generate an exit code 1.
# The below command ensures the script will exit if any non-zero exit code is generated.
set -e

menu_return () {
	echo -e "${UNDERLINEYELLOW}________________________________${ENDCOLOUR}\n"
	echo -e "${MAGENTA}Main Menu${ENDCOLOUR}\n${YELLOW}Your options are:${ENDCOLOUR}\n"
	i="1"
	for OPTION in "${OPTIONS[@]}"; do
		echo -e "$i) $OPTION"
		(( i+=1 ))
	done
	echo ""
}

echo -e "\n${YELLOW}Welcome to the lab project tracker!\nHere you can monitor and edit progress on various lab projects${ENDCOLOUR}"
echo -e "${BOLDCYAN}Please type the number of the option you'd like:${ENDCOLOUR}\n"
OPTIONS=("Overview" "Add" "Remove" "Search" "Exit")
PS3="Type a number: "
select OPTION in "${OPTIONS[@]}"; do
	case $OPTION in
		Overview)
				project_overview u
				menu_return
				;;
		Add)
				bash add.sh
				menu_return
				;;
		Remove)
			 	bash remove.sh
				menu_return
				;;
		Search)
			 	bash search.sh
				menu_return
				;;
		*)
		 		echo -e "\n${MAGENTA}Exiting"
				echo -e "________________________________${ENDCOLOUR}\n"
				exit 1
				;;
	esac
done

