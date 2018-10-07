#!/bin/bash

# 3.2
# $1 - the group
printUsersInGroup(){
	#getent paswwd | awk -F: '{print $1}'
	#groups `getent passwd | awk -F: '{print $1}'` | sed 's/.*: //'
	groups `getent passwd | awk -F: '{print $1}'` | grep ":.*$1" | sed 's/:.*//'
}


# 1.2
# $1 - num of groups
printUsersInGroupsMoreThan(){
	groups `getent passwd | awk -F: '{print $1}'` | awk "{if(NF - 2 > $1) print \$1}"
}


