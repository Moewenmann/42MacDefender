#!/bin/bash

# MODES: remove, ask, warn, off
SHIELD_MODE="ask"

# notifies the user after a successful scan
SHIELD_RUN_NOTIFY="true"

if [ "$SHIELD_MODE" == "off" ]; then
	exit 0
fi

scanfl="$HOME/.zshrc"
scanflbc="$HOME/MacDefender/.zshrc.backup"
scnlst="$HOME/MacDefender/config.scanlist"

if [ ! -f "$scanfl" ]; then
	echo "$scanfl not found!"
	exit 1
fi
if [ ! -f "$scnlst" ]; then
	touch "$scnlst"
	echo "$scnlst not found! Created a new one."
	exit 1
fi

if [ ! -f "$scanflbc" ]; then
	cp "$scanfl" "$scanflbc"
fi

if diff "$scanfl" "$scanflbc" >/dev/null; then
	printf ""
else
	printf "\e[37m[\e[36mMacDefender\e[37m :: \e[35mConfigShield\e[37m] \e[38;5;208mWARNING\e[37m - $scanfl has been modified since the last launch! If this was not you, you should check the file for modifications.\e[0m\n"
fi
cp "$scanfl" "$scanflbc"

tmp_content=$(<"$scanfl")

mode_ask() {
	printf "\e[37m[\e[36mMacDefender\e[37m :: \e[35mConfigShield\e[37m] \e[38;5;208mATTENTION!\e[37m Do you want to remove this line(s) from $scanfl? (recommended!) [y/N] \e[0m"
	read -p "" user_input
	if [ "$user_input" == "y" ] || [ "$user_input" == "Y" ]; then
		echo "$tmp_content" > "$scanfl"
		printf "\e[37m[\e[36mMacDefender\e[37m :: \e[35mConfigShield\e[37m] \e[38;5;208mATTENTION!\e[37m ConfigShield has removed the line(s) from $scanfl. You should check your PC for malicious applications and \e[33mterminate or reload this Terminal!\e[0m\n"
	else
		printf "\e[37m[\e[36mMacDefender\e[37m :: \e[35mConfigShield\e[37m] \e[38;5;208mWARNING!\e[37m ConfigShield has NOT removed the line(s) from $scanfl. You should check your PC and configuration files for malicious applications!\e[0m\n"
	fi
}

while IFS= read -r signature; do
	if [ -z "$signature" ]; then
		continue
	fi
	tmp_content=$(echo "$tmp_content" | grep -vF "$signature")
	while IFS= read -r line; do
		if [[ "$line" == *"$signature"* ]]; then
			fnd=1
			printf "\e[37m[\e[36mMacDefender\e[37m :: \e[35mConfigShield\e[37m] \e[38;5;208mWARNING\e[37m - match found in $scanfl! ($signature)\e[0m\n"
			printf "found this line in \e[36m$scanfl\e[37m: $line\e[0m\n"
			if [ "$SHIELD_MODE" == "remove" ]; then
				echo "$tmp_content" > "$scanfl"
				printf "\e[37m[\e[36mMacDefender\e[37m :: \e[35mConfigShield\e[37m] \e[38;5;208mATTENTION!\e[37m ConfigShield has removed the line from $scanfl. You should check your PC for malicious applications and \e[33mterminate or reload this Terminal!\e[0m\n"
			elif [ "$SHIELD_MODE" == "ask" ]; then
				ask_ate=1
			elif [ "$SHIELD_MODE" == "warn" ]; then
				printf "\e[37m[\e[36mMacDefender\e[37m :: \e[35mConfigShield\e[37m] \e[38;5;208mWARNING!\e[37m ConfigShield is in warn mode and has therefore NOT removed the line from $scanfl. You should check your PC and configuration files for malicious applications!\e[0m\n"
			fi
		fi
	done < "$scanfl"
done < "$scnlst"

if [ "$ask_ate" == "1" ]; then
	mode_ask
fi
if [ "$SHIELD_RUN_NOTIFY" == "true" ] && [ "$fnd" != "1" ]; then
	printf "\e[37m[\e[36mMacDefender\e[37m] ConfigShield has scanned \e[36m$scanfl\e[0m\n"
	exit 0
fi
if [ "$fnd" == "1" ]; then
	printf "\e[1;33mTerminate this Terminal(!)\e[0m\e[37m or press any button to continue... \e[0m\n"
	read -n 1 -s -r -p ""
	exit 1
fi
