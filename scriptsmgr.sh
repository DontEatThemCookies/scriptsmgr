# David Costell's Scripts Manager
# v1.1 [07/18/22]

# CONFIG
SCRIPTS_DIR="/home/$(whoami)/scripts" # The directory containing your scripts
PREF_EDITOR="nano" # Your preferred editor (e.g. vi, nano)
PREF_SHELL="bash" # Your preferred editor (e.g. bash, zsh)
NO_ERR_MSG=0 # If this is set to a non-zero number errormsg() won't output anything
# CONFIG END

errormsg() {
	[ $NO_ERR_MSG -ne 0 ] || (printf "An error has occurred! Last program exited with status $1\n"; exit $?)
}

type curl > /dev/null 2>&1 && CURL_PRESENT="true" # Check for curl

case $1 in # parse $1 (action argument)
	"run")
		# run [$2: file]
		$PREF_SHELL $SCRIPTS_DIR/$2.sh || errormsg $?
	;;
	"runweb")
		# runweb [$2: URL]
		if [ -z $CURL_PRESENT ]; then
			printf "curl is not installed\n"; exit
		else
			curl -fsSL $2 | $PREF_SHELL || errormsg $?
		fi
	;;
	"edit")
		# edit [$2: file]
		$PREF_EDITOR $SCRIPTS_DIR/$2.sh || errormsg $?
	;;
	"about")
		printf "Scripts Manager v1.1 [07/18/22]\nby David Costell\n"
	;;
	*)
		# when [action] is none of the above (invalid)
		printf "Usage: scriptsmgr [action] {additional arguments}\nFull documentation can be found in doc.txt\n"
	;;
esac

