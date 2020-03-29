#!/bin/bash


INSTALLER_CMD_PIP="sudo pip install"
INSTALLER_CMD="sudo apt install"
INSTALLER_OPT="--force-yes --yes"

# install folder
REPODIR=$2/$3

# Basics
PACKAGES="$PACKAGES gdb python2.7 python-pip python-dev git libssl-dev libffi-dev build-essential"
$INSTALLER_CMD $PACKAGES $INSTALLER_OPT

$INSTALLER_CMD_PIP --upgrade pip
$INSTALLER_CMD_PIP --upgrade pwntools

if [[ ! -d "$REPODIR" ]] ; then
    mkdir -p "$REPODIR" 2>/dev/null
fi
cd "$REPODIR"
if [[ ! -d heapwn ]] ; then
	git clone https://github.com/str8outtaheap/heapwn.git
fi

if [[ ! -d peda ]] ; then
	git clone https://github.com/longld/peda.git 
fi

if [[ ! -d Pwngdb ]] ; then
	git clone https://github.com/scwuaptx/Pwngdb.git 
	cp Pwngdb/.gdbinit $2
	sed -i "s#~/peda/#$REPODIR/peda/#g" $2/.gdbinit
	sed -i "s#~/Pwngdb/#$REPODIR/Pwngdb/#g" $2/.gdbinit
fi

if [[ ! -d how2heap ]] ; then
	git clone https://github.com/shellphish/how2heap.git 
fi

if [[ ! -d radare2 ]] ; then
	git clone https://github.com/radareorg/radare2.git
    radare2/sys/install.sh
fi



cd -









