#!/bin/bash

# Console helpers
TER_H1=$'####################################\n####################################'
TER_H2="++++++++++++++++++++++++++++++++++++"
TER_H3="------------------------------------"
TER_SUC="[+]"
TER_ERR="[-]"
TER_DBG="[*]"

# Raw CMD params
PARAM_COMPONENTS=""
PARAM_FILES=""
PARAM_TYPES=""
PARAM_USER=""
PARAM_PACKS=""
PARAM_REPO=""
PARAM_VERBOSE=0
PARAM_NOINSTALL=0
PARAM_QUIET=0

# defaults
DEFAULT_REPO="repo/github"

# Parsed action params
CMD_HOME=""
declare -a CMD_TYPES=()
declare -a CMD_COMPONENTS=()
declare -a CMD_FILES=()
declare -a CMD_PACKS=()
declare -a TARGET_INSTALLERS=()
declare -a TARGET_CONFIGURATORS=()
declare -a TARGET_PACKS=()

function usage(){
	echo "./setup.sh OPTIONS"
	echo "	-f=FILES   : File configurators [dotfiles,snippets,theme]"
	echo "	-c=COMP    : Components installations [essentials]"
	echo "	-p=PACKS   : Packed installations [minimal,full]"
	echo "	-t=TARGET  : machine targets [terminal,desktop]"
	echo "	-u=USER    : username for configurations [terminal,desktop]"
    echo "	-r=REPO    : path to repositories [repo/github]"
	echo "	-n         : No installations"
	echo "	-v         : setup verbosity"
	echo "	-q         : installer verbosity"
	echo "	-h         : help message"
	echo ""
	echo "Example: ./setup.sh -p=workstation -u=odem -v -q"
    echo "Example: ./setup.sh -f=dotfiles,snippets,theme -c=essentials -u=odem -r=repo/github -v -q"
	echo ""
}

function generate_cmd_args(){
	for i in "$@"
	do
	case $i in
		-c=*|--components=*)
		PARAM_COMPONENTS="${i#*=}"
		shift
		;;
		-t=*|--types=*)
		PARAM_TYPES="${i#*=}"
		shift
		;;
		-f=*|--files=*)
		PARAM_FILES="${i#*=}"
		shift
		;;
		-p=*|--packs=*)
		PARAM_PACKS="${i#*=}"
		shift
		;;
		-r=*|--repo=*)
		PARAM_REPO="${i#*=}"
		shift
		;;
		-u=*|--user=*)
		PARAM_USER="${i#*=}"
		shift
		;;
		-v|--verbose)
		PARAM_VERBOSE=1
		shift 
		;;
		-n|--noinstall)
		PARAM_NOINSTALL=1
		shift 
		;;
		-q|--quiet)
		PARAM_QUIET=1
		shift 
		;;
		-h|--help)
		usage
		exit 0
		shift 
		;;
		*)
		      
		;;
	esac
	done
}

function generate_installers(){
	declare -a T_TYPES=("${!1}")
	declare -a T_COMPONENTS=("${!2}")
	for t in "${T_TYPES[@]}"
	do
		for c in "${T_COMPONENTS[@]}"
		do
			INSTALLER="scripts/components/mps-comp-$t-$c.sh"
			if [[ -f $INSTALLER  ]] ; then
				TARGET_INSTALLERS+=($INSTALLER)
			fi
		done
	done
	return 0
}

function generate_packs(){
	declare -a T_PACKS=("${!1}")
	for p in "${T_PACKS[@]}"
	do
		PACK="scripts/packs/mps-pck-$p.sh"
		if [[ -f $PACK  ]] ; then
			TARGET_PACKS+=($PACK)
		fi
	done
	return 0
}

function generate_configurators(){
	declare -a T_CONFIGURATORS=("${!1}")
	for f in "${T_CONFIGURATORS[@]}"
	do
		CONFIGURATOR="scripts/configuration/mps-cfg-$f.sh"
		if [[ -f $CONFIGURATOR  ]] ; then
			TARGET_CONFIGURATORS+=($CONFIGURATOR)
		fi
	done
	return 0
}

function prepare_arguments(){

	# split csv-style action params
	PREPARE_ARG=$1
	CMD_TYPES=(${PREPARE_ARG//,/ })
	PREPARE_ARG=$2
	CMD_COMPONENTS=(${PREPARE_ARG//,/ })
	PREPARE_ARG=$3
	CMD_FILES=(${PREPARE_ARG//,/ })
	PREPARE_ARG=$4
	CMD_PACKS=(${PREPARE_ARG//,/ })

	# User param
	if [[ "$PARAM_USER" == "root"  ]] ; then
		CMD_HOME="/root/"
	elif [[ "$PARAM_USER" == ""  ]] ; then
		CMD_HOME=""
	else
		CMD_HOME="/home/$PARAM_USER"
	fi
	if [[ "$PARAM_REPO" == ""  ]] ; then
		PARAM_REPO="$DEFAULT_REPO"
	fi
	return 0
}

function print_installers(){
	if [[ "$PARAM_VERBOSE" == "1" ]] ; then
		declare -a T_INST=("${!1}")
		echo "$TER_DBG $TER_H2"
		echo "$TER_DBG Installers: "
		echo "$TER_DBG $TER_H2"
		for i in "${T_INST[@]}"
		do
			echo "$TER_DBG $i"
		done
		echo "$TER_DBG $TER_H3"
	fi
	return 0
}

function print_packs(){
	if [[ "$PARAM_VERBOSE" == "1" ]] ; then
		declare -a T_PACKS=("${!1}")
		echo "$TER_DBG $TER_H2"
		echo "$TER_DBG Packs: "
		echo "$TER_DBG $TER_H2"
		for p in "${T_PACKS[@]}"
		do
			echo "$TER_DBG $p"
		done
		echo "$TER_DBG $TER_H3"
	fi
	return 0
}

function print_configurators(){
	if [[ "$PARAM_VERBOSE" == "1" ]] ; then
		declare -a T_CONF=("${!1}")
		echo "$TER_DBG $TER_H2"
		echo "$TER_DBG Configurators: "
		echo "$TER_DBG $TER_H2"
		for i in "${T_CONF[@]}"
		do
			echo "$TER_DBG $i"
		done
		echo "$TER_DBG $TER_H3"
	fi
	return 0
}

function print_cmd_args(){
	if [[ "$PARAM_VERBOSE" == "1" ]] ; then
		declare -a T_INST=("${!1}")
		echo "$TER_DBG $TER_H2"
		echo "$TER_DBG Commandline: "
		echo "$TER_DBG $TER_H2"
		echo "$TER_DBG User      : $PARAM_USER"
		echo "$TER_DBG Types     : $PARAM_TYPES"
		echo "$TER_DBG Components: $PARAM_COMPONENTS"
		echo "$TER_DBG Packs     : $PARAM_PACKS"
        echo "$TER_DBG Repo      : $PARAM_REPO"
		echo "$TER_DBG Files     : $PARAM_FILES"
		echo "$TER_DBG Verbosity : $PARAM_VERBOSE"
		echo "$TER_DBG $TER_H3"
		echo "$TER_DBG "
	fi
	return 0
}

function invoke_installers(){
	declare -a T_INST=("${!1}")
	for installer in "${T_INST[@]}"
	do
		if [[ "$PARAM_NOINSTALL" == "0" ]] ; then
			if [[ "$PARAM_QUIET" == "0" ]] ; then
				$installer "$PARAM_USER" "$CMD_HOME" "$PARAM_REPO"
			else
				$installer "$PARAM_USER" "$CMD_HOME" "$PARAM_REPO" 2&>/dev/null
			fi
		fi
	done
	return 0
}

function invoke_packs(){
	declare -a T_PACK=("${!1}")
	for pack in "${T_PACK[@]}"
	do
		if [[ "$PARAM_NOINSTALL" == "0" ]] ; then
			if [[ "$PARAM_QUIET" == "0" ]] ; then
				./$pack "$PARAM_USER" "$CMD_HOME" "$PARAM_REPO"
			else
				./$pack "$PARAM_USER" "$CMD_HOME" "$PARAM_REPO" 2&>/dev/null
			fi
		fi
	done
	return 0
}

function invoke_configurators(){
	declare -a T_CONF=("${!1}")
	for configurator in "${T_CONF[@]}"
	do
		if [[ "$PARAM_NOINSTALL" == "0" ]] ; then
			if [[ "$PARAM_QUIET" == "0" ]] ; then
				./$configurator "$PARAM_USER" "$CMD_HOME" "$PARAM_REPO"
			else
				./$configurator "$PARAM_USER" "$CMD_HOME" "$PARAM_REPO" 2&>/dev/null
			fi
		fi
	done
	return 0
}


# Parse cmd line arguments
generate_cmd_args "$@"
prepare_arguments "$PARAM_TYPES" "$PARAM_COMPONENTS" "$PARAM_FILES" "$PARAM_PACKS"

generate_installers CMD_TYPES[@] CMD_COMPONENTS[@]
generate_configurators CMD_FILES[@]
generate_packs CMD_PACKS[@]
generate_packs CMD_FILES[@]

# Print info
print_cmd_args
print_installers TARGET_INSTALLERS[@]
print_configurators TARGET_CONFIGURATORS[@]
print_packs TARGET_PACKS[@]

# Start action
invoke_installers TARGET_INSTALLERS[@]
invoke_packs TARGET_PACKS[@]
invoke_configurators TARGET_CONFIGURATORS[@]


