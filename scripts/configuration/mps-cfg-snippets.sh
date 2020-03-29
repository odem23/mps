 #!/bin/bash

if [[ $# -ge 2  ]] ; then
	if [[ -d files/snippets ]] ; then
		if [[ -d $2 ]] ; then
			if [[ ! -d $2/snippets ]] ; then
				mkdir -p $2/snippets >/dev/null
			fi
			cp files/snippets/gitcommitpush.sh $2/snippets

			chown $1:$1 -R $2/snippets/
			chmod a+x -R $2/snippets/*
		else
			echo "DstPath not valid! Exiting now.."
			exit 1
		fi
	else
		echo "Path not valid! Exiting now.."
		exit 1
	fi
else
	echo "Not enough arguments provided! Exiting now.."
	exit 1
fi
