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

function printCurrentTime {
	date +'%a %b %d %I:%M %Z %Y'
}

function changeDirectory {
	echo "where would you like to go? deeper?"
	read local new_dir
	if [ new_dir ] 
	then
		cd '/'
		exec bash
	fi
}

function mainLoop {
	printMenu
	while read chosen_menu 
	do
		case $chosen_menu in 
		1) printCurrentDirectoryName
			;;
		2) changeDirectory
			;;
		*) printCurrentTime
			;;
       		esac	
	printMenu
	echo "Choose the option"
	done
}

mainLoop
