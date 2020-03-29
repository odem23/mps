
#!/bin/bash


if [[ $# -ge 2  ]] ; then
	if [[ -d files/dotfiles ]] ; then
		if [[ -d $2 ]] ; then

            # folders
            mkdir -p $2/.config &>/dev/null

            # fluxbox config
            cp -r files/dotfiles/fluxbox/ $2/.fluxbox

            # lxterminal config
            cp -r files/dotfiles/lxterminal $2/.config/
            update-alternatives --set x-terminal-emulator /usr/bin/lxterminal &>/dev/null

            # tint2 config
            mkdir -p $2/.config/tint2 &>/dev/null
            cp -r files/dotfiles/tint2/tint2rc_launcher $2/.config/tint2/tint2rc
            cp -r files/dotfiles/tint2/tintwizard.conf $2/.config/tint2/tintwizard.conf
            sudo sed -i "s#Icon=accessories-text-editor#Icon=/usr/share/icons/nuoveXT2/32x32/apps/accessories-text-editor.png#g" /usr/share/applications/org.gnome.gedit.desktop

            # tilda config
            cp -r files/dotfiles/tilda $2/.config/

            # dconf 
            dconf load /org/gnome/gedit/ < files/dotfiles/dconf/gedit.settings            

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


