
#!/bin/bash


if [[ $# -ge 2  ]] ; then
	if [[ -d files/dotfiles ]] ; then
		if [[ -d $2 ]] ; then

            # folders
            mkdir -p $2/.config &>/dev/null
            mkdir -p $2/.config/images &>/dev/null

            # wallpaper
            cp -r files/wallpapers/bootsplash.png $2/.config/images/bootsplash.png
            cp -r files/wallpapers/bombed.jpg $2/.config/images/wallpaper.jpg
            echo "GRUB_BACKGROUND=$2/.config/images/bootsplash.png" | sudo tee -a /etc/default/grub
            sudo update-grub

            # privileges
            chown $1:$1 $2 -R

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


