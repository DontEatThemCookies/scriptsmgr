#!/bin/sh
# David Costell's Scripts Manager
# v1.3 [07/21/22]

# CONFIG
SCRIPTS_DIR="${HOME}/scripts" # The directory containing your scripts
PREF_EDITOR="nano" # Your preferred editor (e.g. vi, nano)
PREF_SHELL="bash" # Your preferred editor (e.g. bash, zsh)
EDITOR_FLAGS="" # Flags to run your preferred editor with (can be left blank "")
SHELL_FLAGS="" # Flags to run your preferred shell with (can be left blank "")
CURL_FLAGS="-fsSL" # Flags to run curl with (e.g. -fsSL) (can be left blank "")
CHMOD_SCRIPTS=0 # If set to a non-zero number, chmod +x every unexecutable script edited
# CONFIG END

prompt() {
	printf "Are you sure? (Y/N) "; read -r ANS
	[ "$ANS" = "Y" ] || [ "$ANS" = "y" ] && return 0 || return 1
}

curl --help > /dev/null 2>&1 && CURL_PRESENT=1 # Check for curl

case $1 in # parse $1 (action argument)
	"run")
		# run [$2: file]
		$PREF_SHELL $SHELL_FLAGS "$SCRIPTS_DIR"/"$2".sh
	;;
	"runweb")
		# runweb [$2: URL]
		[ -n "$CURL_PRESENT" ] && prompt
		[ $? -ne 1 ] && curl $CURL_FLAGS "$2" | $PREF_SHELL || printf "curl is not installed in this system\n"; exit
	;;
	"edit")
		# edit [$2: file]
		$PREF_EDITOR $EDITOR_FLAGS "$SCRIPTS_DIR"/"$2".sh
		[ -x "$SCRIPTS_DIR"/"$2".sh ] || [ $CHMOD_SCRIPTS -ne 0 ] && chmod +x "$SCRIPTS_DIR"/"$2".sh
	;;
	"about")
		printf "Scripts Manager v1.3 by David Costell [07/21/2022]\nA shell script to manage other scripts\n"
	;;
	*)
		# when [action] is none of the above (invalid)
		printf "Usage: scriptsmgr [action] {any subargs needed by [action]}\nFull documentation can be found in doc.txt\n"
	;;
esac
