#!/bin/bash

MAC_DEFNDR_STATE="active"
#hash_pw=$(cat password_hash.txt)
hash_pw=$"92cfceb39d57d914ed8b14d0e37643de0797ae56  -"
mdf_dir="$HOME/MacDefender/"
mdf_file="$HOME/MacDefender/macdefender.sh"
zshrc_file="$HOME/.zshrc"
#zshrc_file="$HOME/.bashrc"

if [ ! -f "$zshrc_file" ]; then
	echo "$zshrc_file not found."
	exit 1
fi

if [ -r "$zshrc_file" ]; then
	macdefender_ln=$(grep "MACDEFENDER=" "$zshrc_file")
	if [ -n "$macdefender_ln" ]; then
		MAC_DEFNDR_STATE=$(echo "$macdefender_ln" | sed 's/.*MACDEFENDER="\([^"]*\)".*/\1/')
	fi
	mdfpass_ln=$(grep "MDFPASS=" "$zshrc_file")
	if [ -n "$mdfpass_ln" ]; then
		hash_pw=$(echo "$mdfpass_ln" | sed 's/.*MDFPASS="\([^"]*\)".*/\1/')
	fi
fi

lock_terminal() {
	trap '' SIGINT SIGQUIT SIGTSTP
	while [ "$MAC_DEFNDR_STATE" = "active" ]; do
		printf "\e[37m[\e[36mMacDefender\e[37m] Please unlock terminal: \e[0m"
		read -s -p "" user_input
		echo ""
		user_input_hash=$(printf "$user_input" | shasum)

		if [ "$user_input_hash" = "$hash_pw" ]; then
			clear
			printf "\e[37m[\e[36mMacDefender\e[37m] Terminal unlocked!\e[0m\n"
			MAC_DEFNDR_STATE="inactive"
			break
		else
			clear
			echo "This Terminal is locked! Try again..."
		fi
	done
}

toggle_defender() {
	if [ "$MAC_DEFNDR_STATE" == "active" ]; then
		TG_STATE="inactive"
	else
		TG_STATE="active"
	fi
	sed -i '' "s/MACDEFENDER=\"[^\"]*\"/MACDEFENDER=\"$TG_STATE\"/" "$zshrc_file"
	macdefender_ln=$(grep "MACDEFENDER=" "$zshrc_file")
	if [ -n "$macdefender_ln" ]; then
		MAC_DEFNDR_STATE=$(echo "$macdefender_ln" | sed 's/.*MACDEFENDER="\([^"]*\)".*/\1/')
	fi
	if [ "$MAC_DEFNDR_STATE" == "active" ]; then
		printf "\e[37m[\e[36mMacDefender\e[37m] \e[32mEnabled.\e[0m\n"
	else
		printf "\e[37m[\e[36mMacDefender\e[37m] \e[31mDisabled.\e[0m\n"
	fi
}

main() {
	if [ "$#" -eq 0 ]; then
		lock_terminal
	elif [ "$#" -eq 1 ]; then
		if [ "$1" = "toggle" ]; then
			toggle_defender
		elif [ "$1" = "t" ]; then
			toggle_defender
		else
			lock_terminal
		fi
	else
		lock_terminal
	fi
}

main "$@"
