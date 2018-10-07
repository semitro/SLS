#/bin/bash

# args: $1 = [rwx] $2 = [ugo] $3 = file
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
	pos=$(( $mul * 3 + $shift + 1))
	symbol=`ls -n -- "$3" | cut -c"$pos"-"$pos"`	
	echo $symbol
	if [ "$symbol" = "-" ]; then
		return 0
	else
		return 1
	fi
}

echo isTherePermission r u file
isTherePermission w u file
isTherePermission x u file
isTherePermission r g file
isTherePermission w g file
isTherePermission x g file
isTherePermission r o file
isTherePermission w o file
isTherePermission x o file
