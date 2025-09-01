# zmodload zsh/zprof


# shell history settings
HISTFILE=~/.cache/zsh/history
HISTSIZE=50000
SAVEHIST=1000000
setopt appendhistory
setopt histignoredups


# options
setopt autocd
setopt extendedglob
setopt nomatch
setopt interactivecomments
setopt RM_STAR_WAIT
unsetopt beep
# stty stop undef     # Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')
# bindkey -v


bindkey '^[[1;5C' forward-word  # Ctrl+Right Arrow


autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down


# load custom shell variables
set -o allexport; source ~/.env; set +o allexport


# set terminal to UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8


# To support 256 color schemes
# export TERM="xterm-256color"


# completions
setopt menucomplete
setopt alwaystoend
autoload -Uz compinit
# compinit
compinit -C
zstyle ':completion:*' completer _extensions _complete _match _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "~/.cache/zsh/zcompcache"
zstyle ':completion:*' menu select
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}--[ %d ]--%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}-![ %d (errors: %e) ]!-%f'
zstyle ':completion:*:messages' format ' %F{purple}--- %d ---%f'
zstyle ':completion:*:warnings' format ' %F{red}--- no matches found ---%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete



# Colors
autoload -Uz colors && colors



# exports
export PATH=$PATH:"$HOME/.local/bin"
export PATH=$PATH:"/usr/local/go/bin"
export PATH=$PATH:"$HOME/go/bin"
export PATH=$PATH:"$HOME/.cargo/bin"
export PATH=$PATH:"$HOME/.bun/bin"
# export PATH=$PATH:"$HOME/.spicetify"

export BAT_THEME="base16"


# aliases
alias tdev='sh ~/.config/tmux/tmux-setup.sh'
alias homegit='/usr/bin/git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME'
alias claude="/home/prdx/.claude/local/claude"



# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"
# source /usr/share/fzf/shell/key-bindings.zsh
export FZF_CTRL_R_OPTS="
  --reverse
  --height=30%
"


# bun completions
[ -s "/home/prdx/.bun/_bun" ] && source "/home/prdx/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"


# nvm setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm only on calling use
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



# load custom functions
[[ ! -f ~/.config/zsh/commands.sh ]] || source ~/.config/zsh/commands.sh


# to install starship - curl -sS https://starship.rs/install.sh | sh
export STARSHIP_CONFIG=~/.config/zsh/starship.toml
eval "$(starship init zsh)"


# zinit plugin manager
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load plugins

# zinit light spaceship-prompt/spaceship-prompt

zinit ice wait lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh

zinit ice wait lucid
zinit snippet OMZ::plugins/bgnotify/bgnotify.plugin.zsh

zinit ice wait lucid
zinit load "zsh-users/zsh-completions"

zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit load "zsh-users/zsh-autosuggestions"

# Load syntax highlighting last
zinit ice wait lucid
zinit load "zsh-users/zsh-syntax-highlighting"



# plugin settings
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# SPACESHIP_TIME_SHOW=true
# SPACESHIP_USER_SHOW="always"
# SPACESHIP_HOST_SHOW="always"

# SPACESHIP_EXIT_CODE_SHOW=true
# SPACESHIP_ASYNC_SHOW_COUNT=true
# SPACESHIP_ASYNC_SYMBOL=""

# SPACESHIP_PROMPT_PREFIXES_SHOW=false


# zprof
