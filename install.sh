#!/bin/bash

mdf_installed=$(grep "~/MacDefender/macdefender.sh" ~/.zshrc)
if grep -q "~/MacDefender/macdefender.sh" ~/.zshrc; then
	echo "MacDefender is already installed."
	exit 1
else
	mkdir ~/MacDefender
	curl https://raw.githubusercontent.com/Moewenmann/42MacDefender/main/macdefender.sh > ~/MacDefender/macdefender.sh
	curl https://raw.githubusercontent.com/Moewenmann/42MacDefender/main/configshield.sh > ~/MacDefender/configshield.sh
	#cp macdefender.sh ~/MacDefender/macdefender.sh
	#cp configshield.sh ~/MacDefender/configshield.sh
	chmod +x ~/MacDefender/macdefender.sh
	chmod +x ~/MacDefender/configshield.sh
fi

if [ ! -f "$mdf_installed" ]; then
	cat <<EOT >> ~/.zshrc

### ### ### MacDefender | MDf v2 | github.com/Moewenmann ### ### ###
MACDEFENDER="active"

MDFPASS="92cfceb39d57d914ed8b14d0e37643de0797ae56  -"

alias lock="~/MacDefender/macdefender.sh"
alias lll="~/MacDefender/macdefender.sh"
alias mdf="~/MacDefender/macdefender.sh"
alias macdefender="~/MacDefender/macdefender.sh"
alias MacDefender="~/MacDefender/macdefender.sh"
EOT
	zshrc_file="$HOME/.zshrc"
	echo "~/MacDefender/configshield.sh" | cat - "$zshrc_file" > tmp && mv tmp "$zshrc_file"
	echo "~/MacDefender/macdefender.sh" | cat - "$zshrc_file" > tmp && mv tmp "$zshrc_file"
	if grep -q "MACDEFENDER" ~/.zshrc; then
		echo "MacDefender installed successfully."
	else
		echo "MacDefender installation failed."
	fi
	if [ ! -f "$config_file" ]; then
		touch ~/MacDefender/config.scanlist
		cat <<EOT >> ~/MacDefender/config.scanlist
masterplan.sh
install.sh
parrot.live
ascii.live
alias rm=
alias cd=
alias ls=
alias nano=
alias cat=
alias .=
alias ./=
EOT
		echo "Scanlist created."
	fi
else
	echo "install failed."
fi
