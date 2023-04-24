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

# Set some useful configuration paths
CONFIG_DIR=$XDG_CONFIG_HOME/zsh
DATA_DIR=$XDG_DATA_HOME/zsh
FUNCTIONS_DIR=$CONFIG_DIR/functions
PLUGIN_MANAGER=$CONFIG_DIR/plugin-manager
export ZSH_PLUGINS_DIR=$DATA_DIR/plugins

# Make sure that the DATA_DIR exists as this is expected by the history file
mkdir -p $DATA_DIR

# Expand the fpath
fpath=($PLUGIN_MANAGER $FUNCTIONS_DIR $fpath)

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
setopt LOCAL_OPTIONS        # Don't permanently change options from inside a function
setopt PROMPT_SUBST

export HISTFILE=$DATA_DIR/.history
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE

### Environment variables
# NOTE: The PATH is extended and exported from this file
[[ -f $CONFIG_DIR/.zsh_variables ]] && . $CONFIG_DIR/.zsh_variables

### Custom functions
[[ -d $FUNCTIONS_DIR ]] && [[ "$(/usr/bin/ls -A $FUNCTIONS_DIR)" ]] && autoload -Uz $FUNCTIONS_DIR/**/*(.)

### Plugins
typeset -A plugins

# Specify the plugins as a key:value pair in a hash with the key being the name
# of the Git repository and the value being the file that needs to be sourced
plugins=(
    "zsh-users/zsh-autosuggestions" ""
    "zsh-users/zsh-syntax-highlighting" ""
    "romkatv/gitstatus" "gitstatus.prompt.zsh"
)

[[ -d $PLUGIN_MANAGER ]] && autoload -Uz $PLUGIN_MANAGER/**/*(.) && plugin_manager_loaded=true

[[ $plugin_manager_loaded ]] && for plugin plugin_file in "${(@kv)plugins}"; do
    zsh_load_plugin $plugin $plugin_file
done

### Aliases
[[ -f $CONFIG_DIR/.zsh_aliases ]] && . $CONFIG_DIR/.zsh_aliases

### Prompts
[[ -f $CONFIG_DIR/.zsh_prompts ]] && . $CONFIG_DIR/.zsh_prompts

