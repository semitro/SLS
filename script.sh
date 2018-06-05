#!/bin/bash

function printMenu {
	echo '1 - print name of current directory
2 - change current directory
3 - print date and time
4 - print file content
5 - copy file
6 - exit'
}

function printCurrentDirectoryName {
	echo `pwd | gawk -F '/' ' {print $NF}'`
}


function mainLoop {
	printMenu
	while read chosen_menu 
	do
		case $chosen_menu in 
		1) printCurrentDirectoryName
			;;
		2) echo '2' 
			;;
		*) echo "enter correct value"
			;;
       		esac	
	printMenu
	echo "Choose the option"
	done
}

mainLoop
