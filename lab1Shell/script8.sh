#!/bin/bash

RED='\033[1;31m'
NC='\033[0m'
err_file=$(echo ~/lab1_err)

trap catchInt 2 
catchInt(){
	echo "The mafia was killed"
	exit 0
}

printError(){
	echo -e "${RED}Error:$1$NC" 1>&2
}

# input an argument and execute command with it
# if the arg is not zero
read_exec(){
	read file_name
	if [ -n file_name ]; then
		"$1" "$file_name" 
	fi
}

printMenu(){
	echo '1 - print name of current directory
2 - change current directory
3 - create file
4 - permit writing to all 
5 - delete file
6 - exit'
}

printCurrentDirectoryName(){
	pwd -P 2>$err_file || echo ":(" >&2
}

changeDirectory(){
 	( cd -- "$1" 2>> $err_file ) &&
	 cd -- "$1" || printError ":("
} 

createFile(){
	if [ -e "$1" ]; then
		printError "file already exists"
		return
	fi
	touch -- "$1" 2>> $err_file ||  printError "file :("
}

permitWritingToAll(){
	chmod a+w "$1" >&2 2>> $err_file || printError ":("
}

destroyFile(){
	if ! [ -e "$1" ]; then
		return
	fi
	echo "rm: remove $1 (yes/no)?"
	read confirm
	if  [ "yes" = "$confirm" ] || [ "y" = "$confirm" ]; then	
		rm  -- "$1" 2>> $err_file || printError "rm :(" 
		echo "done" >&2
	fi
}

mainLoop(){
	export IFS=""
	printMenu
	while read chosen_menu 
	do
		case $chosen_menu in 
		1) printCurrentDirectoryName
			;;
		2) echo "where would you like to go? deeper?"
			read_exec "changeDirectory"
			;;
		3) 	echo "Enter file name"
			read_exec "createFile"
			;;
		4) echo "Enter file name"
			read_exec "permitWritingToAll"
			;;
		5) echo "Which file do you want to destroy?"
			read_exec "destroyFile"
			;;
		6) break
			;;
		7|"ls") ls
			;;
		*) printError "Enter correct value" 
			;;
       		esac	
	printMenu
	echo "Choose the option"
	done
}

mainLoop
