#!/bin/bash


INSTALLER_CMD="sudo apt install"
INSTALLER_OPT="--yes"

# Basics
PACKAGES="$PACKAGES vim git bzip2 zip unzip"

# OS
PACKAGES="$PACKAGES sudo dconf-cli dconf-editor dbus-x11 psmisc cron nload"

# Build
PACKAGES="$PACKAGES gcc build-essential gawk"

# Networking
PACKAGES="$PACKAGES nmap tcpdump dnsutils net-tools whois ssh"

$INSTALLER_CMD $PACKAGES $INSTALLER_OPT






