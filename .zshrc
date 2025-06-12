# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi


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

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down


# load custom shell variables
set -o allexport; source ~/.env; set +o allexport


# completions
setopt menucomplete
setopt alwaystoend
autoload -Uz compinit
compinit
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


# bindkey -e

# Colors
autoload -Uz colors && colors


# plugins
source ~/.config/zsh/antigen.zsh

antigen use oh-my-zsh
antigen bundle git
antigen bundle bgnotify

antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting # should be last sourced
# antigen bundle marlonrichert/zsh-autocomplete

# antigen theme romkatv/powerlevel10k
# antigen theme spaceship-prompt/spaceship-prompt

antigen apply

# plugin settings
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# # SPACESHIP_TIME_SHOW=true
# # SPACESHIP_USER_SHOW="always"
# # SPACESHIP_HOST_SHOW="always"

# SPACESHIP_EXIT_CODE_SHOW=true
# # SPACESHIP_ASYNC_SHOW_COUNT=true
# SPACESHIP_ASYNC_SYMBOL=""


# exports

# set terminal to UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# To support 256 color schemes
export TERM="xterm-256color"

# Path exports
export PATH=$PATH:"$HOME/.local/bin"
export PATH=$PATH:"/usr/local/go/bin"
# export PATH=$PATH:"$(yarn global bin)"
export PATH=$PATH:"$HOME/.cargo/bin"
export PATH=$PATH:"$HOME/.bun/bin"

# aliases
alias tdev='sh ~/.config/tmux/tmux-setup.sh'
alias homegit='/usr/bin/git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME'


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.config/zsh/p10k.zsh ]] || source ~/.config/zsh/p10k.zsh


# load custom functions
[[ ! -f ~/.config/zsh/commands.sh ]] || source ~/.config/zsh/commands.sh

# to install starship - curl -sS https://starship.rs/install.sh | sh
export STARSHIP_CONFIG=~/.config/zsh/starship.toml
eval "$(starship init zsh)"


# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"
# source /usr/share/fzf/shell/key-bindings.zsh
export FZF_CTRL_R_OPTS="
  --reverse
  --height=30%
"


# bat configs
export BAT_THEME="base16"



# bun completions
[ -s "/home/prdx/.bun/_bun" ] && source "/home/prdx/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"

export PATH=$PATH:/home/prdx/.spicetify

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
