# Explicitly set the XDG environment variables
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# Make sure that all above directories are present
#xdg_paths=(
# Set the ZSH configuration directory
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

