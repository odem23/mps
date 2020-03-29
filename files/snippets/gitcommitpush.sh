#!/bin/bash

USER=`whoami`
sudo chown $USER:$USER ./* -R
git pull

if [ $# -ge 1 ] ; then
    git add -A
    git commit -am "$1"
    git push
else
    echo "Stopped! No message given..."
fi

