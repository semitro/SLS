#!/bin/bash

error_file="~lab1_err"

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
	( cd -- "$1" 2>> ~/lab1_err)
	if [ $? -ne 0 ]
	then
	echo "An error has occured" 1>&2
	fi
}

function out_file() {
	content=$(cat "$1" 2>~/lab1_err)
	if [ $? -eq 0 ]
	    then echo "$content"
		else
			echo "An error has occured during file outing"
	    fi	    
	echo "$content"
}

function copy_file {
	src = $1
	dst = $2
}

function mainLoop {
	printMenu
	while read chosen_menu 
	do
		case $chosen_menu in 
		1) printCurrentDirectoryName
			;;
		2) echo "where would you like to go? deeper?"
			read file_name
			if [ file_name ]
			then
		       		changeDirectory $file_name
			fi
			;;
		3) printCurrentTime
			;;
		4) echo "which file to you want to examine?"
			read file_name
			if [ file_name ]
			then
				out_file $file_name
			fi
			;;
		5) echo "copy file:"
			read copy_src
			#if [ copy_src ]
			;;
		6) break
			;;
		*) echo "Enter correct value" 
			;;
       		esac	
	printMenu
	echo "Choose the option"
	done
}

mainLoop

