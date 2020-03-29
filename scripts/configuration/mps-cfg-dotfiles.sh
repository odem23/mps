#!/bin/bash

if [[ $# -ge 2  ]] ; then
	if [[ -d files/dotfiles ]] ; then
		if [[ -d $2 ]] ; then
			cp files/dotfiles/vim/.vimrc "$2"
			cp files/dotfiles/bash/.bashrc "$2"
		else
			echo "DstPath not valid! Exiting now.."
			exit 1
		fi
	else
		echo "SrcPath not valid! Exiting now.."
		exit 1
	fi
else
	echo "Not enough arguments provided! Exiting now.."
	exit 1
fi
