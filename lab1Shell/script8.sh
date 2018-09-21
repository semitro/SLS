#!/bin/bash

RED='\033[1;31m'
NC='\033[0m'
err_file=$(echo ~/lab1_err)
echo $err_file
catchKill(){
	echo "The mafia was killed"
	exit 0
}

trap catchKill 8 

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

printError(){
	echo -e "${RED}Error:$1$NC" 1>&2
}

changeDirectory(){
 	( cd -- "$1" 2>> $err_file )
	if [ $? -ne 0 ]
	then
		#echo -e "${RED}An error has ocurred$NC" 1>&2
		echo "An error has ocurred" 1>&2
	else
		cd -- "$1"
	fi
} 

createFile(){
	echo $1
	if [ -e "$1" ]; then
		printError "file already exists"
		return
	fi
	touch -- "$1" 2>> $err_file
	if [ -n $? ]; then
		echo "Eroor" 1>&2
	fi
}

permitWritingToAll(){
	chmod a+w "$1" >&2 2>> $err_file
}

destroyFile(){
	if ! [ -e "$1" ]; then
		#echo "safsf" 1>&2
		return
	fi
	exec 5>/dev/pts/156
	echo "rm: remove $1 (да/нет)?"
	echo "rm: remove $1 (да/нет)?" >&5 
	read confirm
	if [ "да" = "$confirm" ] || [ "yes" = "$confirm" ] || [ "y" = "$confirm" ]; then	
		 rm  -- "$1" 2>> $err_file || echo ":(" 
		 if ! [ $0 -eq 0 ]; then
			echo "no." 1>&2
		fi

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
			read file_name
			if [ -n "$file_name" ]
		 	then	
				changeDirectory "$file_name"
			fi
			;;
		3) 	echo "Enter file name"
			read file_name
			echo "$file_name"
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
		5) echo "Which file do you want to destroy?"
			read file_name
			destroyFile "$file_name"
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
