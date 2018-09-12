#!/bin/bash

RED='\033[1;31m'
NC='\033[0m'

catchKill(){
	echo "The mafia was killed"
	exit 0
}

trap  "catchKill" SIGINT

printMenu(){
	echo '1 - print name of current directory
2 - change current directory
3 - create file
4 - permit writing to all 
5 - delete file
6 - exit'
}

printCurrentDirectoryName(){
	echo `pwd | gawk -F '/' ' {print $NF}'`
}


changeDirectory(){
	( cd -- "$1" 2>> ~/lab1_err )
	if [ $? -ne 0 ]
	then
		#echo -e "${RED}An error has ocurred$NC" 1>&2
		echo "An error has ocurred" 1>&2
	fi
} 

createFile(){
	echo $1
	if [ -e "$1" ]; then
		echo -e "${RED}Error: file already exists $NC" 1>&2
		return
	fi
	touch -- "$1" 2>> ~/lab1_err 
}

permitWritingToAll(){
	chmod a+w "$1" >&2
}

mainLoop(){
	printMenu
	while read chosen_menu 
	do
		case $chosen_menu in 
		1) printCurrentDirectoryName
			;;
		2) echo "where would you like to go? deeper?"
			read file_name
			if [ -n "$file_name" ]
		 	then	
				changeDirectory $file_name
			fi
			;;
		3) 	echo "Enter file name"
			read file_name
			echo $file_name
			if [ -n "$file_name" ]; then
				createFile "$file_name"
			fi
			;;
		4) echo "Enter file name"
			read file_name
			if [ -n "$file_name" ]
			then
				permitWritingToAll $file_name
			fi
			;;
		5) echo "which file do you want to copy?"
			read copy_src
			if [ -n "$copy_src" ]
			then
				echo "where do you want to lay it?"
				read copy_dst
				if [ -n "$copy_dst" ]
				then
					copy_file $copy_src $copy_dst
				fi
			fi
			;;
		6) break
			;;
		7|"ls") ls
			;;
		*) echo "Enter correct value" 
			;;
       		esac	
	printMenu
	echo "Choose the option"
	done
}

mainLoop
