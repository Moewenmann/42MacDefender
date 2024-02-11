#!/bin/bash

mkdir ~/MacDefender
curl https://github.com/Moewenmann/42MacDefender/blob/main/macdefender.sh > ~/MacDefender/macdefender.sh
chmod +x ~/MacDefender/macdefender.sh
cat <<EOT >> ~/.zshrc

### ### ### ### MacDefender ### ### ### ###
MACDEFENDER="active"

TIMEKEEPER="inactive"

LOCKTIME="600"

~/MacDefender/macdefender.sh

alias lock="~/MacDefender/macdefender.sh"
alias macdefender="~/MacDefender/macdefender.sh"
alias MacDefender="~/MacDefender/macdefender.sh"
EOT

echo ""
