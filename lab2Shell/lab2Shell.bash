#/bin/bash

# args: $1 = [rwx] $2 = [ugo]
isTherePermission(){
	mul=0
	shift=0
	case $1 in
	"r") shift=0
		;;
	"w") shift=1
		;;
	"x") shift=2
		;;
	esac

	case $2 in
	"u") mul=0
		;;
	"g") mul=1
		;;
	"o") mul=2
		;;
	esac
	echo $(( $1 * $2 ))
	
}

isTherePermission 4 2
