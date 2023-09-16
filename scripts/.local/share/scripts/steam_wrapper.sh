#!/usr/bin/env sh

# Edit steam's .desktop file in /usr/share/applications/ and change the Exec
# line to point to the wrapper script with
# Exec=/home/yourname/scripts/steam_wrapper.sh
# obviously changing the path to the location of the script

HOME=$HOME/.local/share/Steam
mkdir $HOME
exec /usr/bin/steam "$@"

