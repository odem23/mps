#!/bin/bash


INSTALLER_CMD="sudo apt install"
INSTALLER_OPT="--force-yes --yes"

# Filemanager
PACKAGES=""

# Misc
PACKAGES="$PACKAGES numlockx"

# gedit
PACKAGES="$PACKAGES gedit gedit-plugins"

# icons
PACKAGES="$PACKAGES lxde-icon-theme gnome-extra-icons"

# settings
PACKAGES="$PACKAGES arandr"

# file manager
PACKAGES="$PACKAGES thunar thunar-data thunar-archive-plugin thunar-media-tags-plugin thunar-volman xfce4-goodies xfce4-places-plugin thunar-gtkhash thunar-vcs-plugin file-roller gedit gedit-plugins"

# shells
PACKAGES="$PACKAGES gnome-terminal lxterminal tilda"

# misc
PACKAGES="$PACKAGES texlive-full pandoc wicd-gtk"

# window manager and essentials
PACKAGES="$PACKAGES fluxbox lightdm xorg xserver-xorg-video-nouveau xserver-xorg-video-vesa arandr xscreensaver"

# essential tools
PACKAGES="$PACKAGES galculator evince wbar wbar-config conky wmctrl tint2"

# other
PACKAGES="$PACKAGES gimp imagemagick-6-common vlc thunderbird firefox-esr"

$INSTALLER_CMD $PACKAGES $INSTALLER_OPT



