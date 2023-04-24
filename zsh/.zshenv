# Explicitly set the XDG environment variables
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# Make sure that all above directories are present
xdg_paths=(
    $XDG_CONFIG_HOME
    $XDG_CACHE_HOME
    $XDG_DATA_HOME
    $XDG_STATE_HOME
)

for xdg_path in $xdg_paths; do
    mkdir -p $xdg_path
done

# Set the ZSH configuration directory
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

