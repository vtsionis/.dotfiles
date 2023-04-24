# Store interactive Python shell history in $XDG_DATA_HOME/python/python_history
# instead of ~/.python_history.
#
# Create the following .config/pythonstartup.py file
# and export its path using PYTHONSTARTUP environment variable:
#
# export PYTHONSTARTUP="${XDG_CONFIG_HOME:-$HOME/.config}/pythonstartup.py"

import atexit
import os
import readline
from pathlib import Path

hist_dir = os.path.join(os.getenv("XDG_DATA_HOME"), "python")
hist_file = os.path.join(hist_dir, "python_history")

# Make sure that the history directory exists
Path(hist_dir).mkdir(parents = True, exist_ok = True)

try:
    readline.read_history_file(hist_file)
except OSError:
    # Do the same for the history file itself
    open(hist_file, "a+")
    pass

if readline.get_current_history_length() == 0:
    readline.add_history("# history created")

def write_history():
    try:
        readline.write_history_file(hist_file)

        # default history len is -1 (infinite), which may grow unruly
        readline.set_history_length(10000)
    except OSError:
        pass

atexit.register(write_history)

