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

function out_file {
	echo $0
	cat "$0"
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
		3) printCurrentTime
			;;
		4) echo "which file to you want to examine?"
			read local file_name
			if [ file_name ]
			then
				out_file $file_name
			fi
			;;
		*) echo "Enter correct value" 
			;;
       		esac	
	printMenu
	echo "Choose the option"
	done
}

mainLoop
