A set of scripts to install default workspaces

	./setup.sh OPTIONS
		-f=FILES   : File configurators [dotfiles,snippets]
		-c=COMP    : Components installations [essentials]
		-p=PACKS   : Packed installations [minimal,full]
		-t=TARGET  : machine targets [terminal,desktop]
		-u=USER    : username for configurations [terminal,desktop]
		-n         : No installations
		-v         : setup verbosity
		-q         : installer verbosity
		-h         : help message
	
	Example Server : ./setup.sh -f=dotfiles,snippets -c=essentials -t=terminal -p=minimal -u=foouser -v
	
	Example Desktop: ./setup.sh -f=dotfiles,snippets -c=essentials -t=desktop -p=workstation -u=foouser -v
	
