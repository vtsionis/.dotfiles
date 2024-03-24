# Note that the ZDOTDIR environment variable should already be set by sourcing
# the $HOME/.zshenv file in the initial set up of Zsh

# Explicitly set the XDG environment variables
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

for xdg_path in $XDG_CONFIG_HOME $XDG_CACHE_HOME $XDG_DATA_HOME $XDG_STATE_HOME; do
    mkdir -p $xdg_path
done

# Specify location of zcompdump file
autoload -Uz compinit
compinit -d $XDG_CACHE_HOME/.zcompdump

# Use Vi editing mode
bindkey -v

# Enabling completion system
# see Chapter 20 [Completion System], page 215 | the manual

### Create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# Setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    autoload -Uz add-zle-hook-widget
    function zle_application_mode_start { echoti smkx }
    function zle_application_mode_stop { echoti rmkx }
    add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop

    # Better searching through history with the up and down arrows
    autoload -Uz up-line-or-beginning-search
    autoload -Uz down-line-or-beginning-search
    zle -N up-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey "$key[Up]" up-line-or-beginning-search
    bindkey "$key[Down]" down-line-or-beginning-search
fi

# Set the HISTORY_DIR and make sure that it exists since Zsh will not be able
# to create the history file if not all intermediate directories exist
HISTORY_DIR=$XDG_DATA_HOME/zsh
mkdir -p $HISTORY_DIR

export HISTFILE=$HISTORY_DIR/.history
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE

### Options
# TBD:
# NOMATCH
# BAD_PATTERN

unsetopt BEEP
unsetopt HIST_BEEP
unsetopt NOTIFY

setopt AUTO_CD
setopt EXTENDED_GLOB
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_FUNCTIONS
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt LOCAL_OPTIONS # Don't permanently change options from inside a function
setopt PROMPT_SUBST

### Environment variables
if [[ -f $ZDOTDIR/.zsh_variables ]]; then
    source $ZDOTDIR/.zsh_variables
fi

### Plugins
if [[ -f $ZDOTDIR/.zsh_plugins ]]; then
    # Initialize the plugin manager and any installed plugins
    source $ZDOTDIR/.zsh_plugins
fi

### Custom functions
for fn in $ZDOTDIR/functions/**/*(N); do
    # Note that custom functions are expected to be stored as single files in
    # the root functions directory
    [[ -f $fn ]] && autoload -Uz $fn
done

### Prompts
if [[ -f $ZDOTDIR/.zsh_prompts ]]; then
    source $ZDOTDIR/.zsh_prompts
fi

### Aliases
if [[ -f $ZDOTDIR/.zsh_aliases ]]; then
    source $ZDOTDIR/.zsh_aliases
fi

