#!/bin/bash

mkdir ~/MacDefender
#curl https://github.com/Moewenmann/42MacDefender/blob/main/macdefender.sh > ~/MacDefender/macdefender.sh
cp macdefender.sh ~/MacDefender/macdefender.sh
chmod +x ~/MacDefender/macdefender.sh

mdf_installed=$(grep "### ### ### MacDefender | MDf v1" ~/.zshrc)
if [ ! -f "$mdf_installed" ]; then
	cat <<EOT >> ~/.zshrc

### ### ### MacDefender | MDf v1 | github.com/Moewenmann ### ### ###
MACDEFENDER="active"

TIMEKEEPER="inactive"

LOCKTIME="600"

MDFPASS="92cfceb39d57d914ed8b14d0e37643de0797ae56  -"

~/MacDefender/macdefender.sh

alias lock="~/MacDefender/macdefender.sh"
alias lll="~/MacDefender/macdefender.sh"
alias mdf="~/MacDefender/macdefender.sh"
alias macdefender="~/MacDefender/macdefender.sh"
alias MacDefender="~/MacDefender/macdefender.sh"
EOT
	echo "finished."
else
	echo "install failed."
fi
