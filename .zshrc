# Path to your oh-my-zsh installation.
export ZSH=/home/arsh/.oh-my-zsh

# Set name of the theme to load.
#ZSH_THEME="xiong-chiamiov-plus"
#ZSH_THEME="customtheme"
ZSH_THEME='spaceship'
SPACESHIP_PROMPT_TRUNC=0
SPACESHIP_DIR_TRUNC=0
SPACESHIP_PYENV_SYMBOL='\b \b'
SPACESHIP_PYENV_SHOW=true
SPACESHIP_NODE_SHOW=false

# set python3 as default python
# alias python=python3
# alias pip=pip3

# Set default user
DEFAULT_USER=arsh

# set terminal to UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# To support 256 color schemes
export TERM="xterm-256color"

# Installed plugins
plugins=(git bgnotify zsh-autosuggestions)

# Alias for dotfiles repo
alias homegit='/usr/bin/git --git-dir=$HOME/dotfiles/.git/ --work-tree=$HOME'

# Alias for tmux dev environment 
alias tdev='sh ~/utilities/tmux-setup.sh'

# AWS SSH Aliases
export AWS='ec2-54-214-216-59.us-west-2.compute.amazonaws.com'
alias aws='ssh -R 52698:localhost:23698 paradox@$AWS'

export AWSL='ec2-54-159-68-183.compute-1.amazonaws.com'
alias aws-lyntcube='ssh -R 52698:localhost:52698 lyntcube@$AWSL'

export AWS_MARTY='ec2-52-52-84-61.us-west-1.compute.amazonaws.com'
alias aws-marty='ssh marty@$AWS_MARTY'

export AWS_LYNT='ec2-35-168-121-215.compute-1.amazonaws.com'
alias aws-lynt='ssh lyntcube@$AWS_LYNT'

# Path exports
# export PATH="/home/arsh/Softwares/node-v4.4.3-linux-x64/bin":$PATH
export PATH=$PATH:"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
# export PATH="/home/arsh/miniconda3/bin":$PATH
export PATH=$PATH:"/home/arsh/.local/bin"
export PATH=$PATH:"/usr/local/go/bin"

#  Zsh gives a sanity check for 'rm *'
setopt RM_STAR_WAIT

# path for pyenv
# export PATH="/home/arsh/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

source $ZSH/oh-my-zsh.sh
source ~/utilities/commands.sh
#------------------------ other commented settings --------------------------------------------------------------------

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# User configuration


# export MANPATH="/usr/local/man:$MANPATH"


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


