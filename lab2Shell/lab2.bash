#!/bin/bash

# See the task at https://se.ifmo.ru/~dima/unix/2.html

# spaces in the names!
# 1.1
# $1 - file name
printFilesWhichIsHardLinksTo(){
	inode=$(ls -i -- "$1" | awk '{print $1}')
	# space in the name!
	files=$(ls -il | sed '1d' | awk '{print $1"/"$NF}') #inode/file
	for file in $files ; do
		currentINode=$(echo "$file" | awk -F'/' '{print $1}')
		if [ "$inode" = "$currentINode" ] ; then
			echo "$file" | awk -F'/' '{print $2}'
		fi
	done
}

# 1.2
# $1 - num of groups
printUsersInGroupsMoreThan(){
	groups `getent passwd | awk -F: '{print $1}'` | awk "{if(NF - 2 > $1) print \$1}"
}

# 1.1
# $1 - dir where another dirs is place
printDirsOfDir(){
	# awk gets name ( cases of spaces are handled)
	dirs=$(ls -lt -- "$1" | grep ^d \
		| awk '{for(i=9; i<=NF; i++) printf("%s ",$i); print "" }' | sed 's/.$//')
	#(	>&2 echo "$dirs" )
	echo "$dirs"
}

getDirsWhereIsNoMoreThanOneSubdir(){
	dirs=$(printDirsOfDir ".")
	IFS=$'\n'
	for subdir in $dirs; do
		subSubDirs=$(printDirsOfDir "$subdir")
		subDirsQuantity=$(echo "$subSubDirs" | grep -v '^$' | wc -l)
		if [ $subDirsQuantity -gt 1 ]; then
			echo "$subdir"
		fi
	done
}

# 2.2
# $1 - num of users
getGroupsWithMoreThanNUsers(){
	
	v=`getent group | awk -F: '{print $1}' ` 
	for i in $v ; do
		if [ $(printUsersInGroup "$i" | wc -l) -gt $1 ] ; then
			echo $i
		fi
	done
}

# 3.2
# $1 - the group
printUsersInGroup(){
	#getent paswwd | awk -F: '{print $1}'
	#groups `getent passwd | awk -F: '{print $1}'` | sed 's/.*: //'
	groups `getent passwd | awk -F: '{print $1}'` | grep ":.*$1" | sed 's/:.*//'
}

getDirsWhereIsNoMoreThanOneSubdir
