 #!/bin/bash

./scripts/components/mps-comp-terminal-essentials.sh $1 $2 $3
./scripts/components/mps-comp-desktop-essentials.sh $1 $2 $3
./scripts/components/mps-comp-terminal-re.sh $1 $2 $3
./scripts/configuration/mps-cfg-dotfiles.sh $1 $2 $3
./scripts/configuration/mps-cfg-snippets.sh $1 $2 $3
./scripts/configuration/mps-cfg-desktop.sh $1 $2 $3
./scripts/configuration/mps-cfg-theme.sh $1 $2 $3
