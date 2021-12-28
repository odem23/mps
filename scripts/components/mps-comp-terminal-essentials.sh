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
PACKAGES="$PACKAGES nmap tcpdump dnsutils net-tools whois ssh iptables shorewall"

# Security
PACKAGES="$PACKAGES iptables shorewall"

$INSTALLER_CMD $PACKAGES $INSTALLER_OPT

if [[ -d files/etc/shorewall ]] ; then
    if [[ -d /etc/shorewall ]] ; then
        sudo cp files/etc/shorewall/interfaces /etc/shorewall/
        sudo cp files/etc/shorewall/policy /etc/shorewall/
        sudo cp files/etc/shorewall/rules /etc/shorewall/
        sudo cp files/etc/shorewall/zones /etc/shorewall/
    else
        echo "DstPath not valid! Exiting now.."
        exit 1
    fi
else
    echo "SrcPath not valid! Exiting now.."
    exit 1
fi

sudo shorewall restart




