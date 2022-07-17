# David Costell's Scripts Manager
# v1.0 [07/17/22]

# CONFIG
SCRIPTS_DIR="/home/$(whoami)/scripts" # The directory containing your scripts
PREF_EDITOR="nano" # Your preferred editor (e.g. vi, nano)
PREF_SHELL="bash" # Your preferred editor (e.g. bash, zsh)
NO_ERR_MSG=1 # If this is set to a non-zero number errormsg() won't output anything
# CONFIG END

errormsg() {
	[ $NO_ERR_MSG -ne 1 ] && (printf "Error encountered, exiting with status $1\n"; exit $1)
}

case $1 in
	"run")
		$PREF_SHELL "$SCRIPTS_DIR/$2.sh" || errormsg $?
	;;
	"edit")
		$PREF_EDITOR "$SCRIPTS_DIR/$2.sh" || errormsg $?
	;;
	"about")
		printf "Scripts Manager v1.0 [07/17/22]\nby David Costell\n"
	;;
	*)
		printf "Usage: scriptsmgr [action] {additional arguments}\nConsult doc.txt for further info\n"
	;;
esac

