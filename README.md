# Dotfiles

My Dotfiles for Vim, Tmux, Zsh and Tilda

![Screenshot](/Pictures/full-setup.png?raw=true)

## Themes/Colorschemes
  * Vim Colorscheme: [luna-term](https://github.com/notpratheek/vim-luna) 
  * Vim Statusline: Custom theme using [vim-airline](https://github.com/vim-airline/vim-airline) - [customtheme.vim](https://github.com/Arsh23/dotfiles/blob/master/.vim/autoload/airline/themes/customtheme.vim)
  * Zsh prompt: [Spaceship](https://git.io/spaceship)
  * Tmux Statusline: Custom theme - [Customtheme.sh](https://github.com/Arsh23/dotfiles/blob/master/utilities/customtheme.sh)

## First time setup  
This is mostly for my personal use but if you are following along this repo, this might help

### Initial setup
For a complete bare system
```sh
sudo apt update && sudo apt upgrade
sudo apt install git gcc curl xdotool entr build-essential cmake python3-dev
git config --global user.email "..."
git config --global user.name "Arsh"
git config --global credential.helper store
# copy .gitignore_global
git config --global core.excludesfile '~/.gitignore_global'
git config --global core.editor vim
```

### Vim
I compile vim to enable support for python3, clientserver and clipboard
```sh
sudo apt build-dep vim
sudo apt install xorg xorg-dev libx11-dev libxtst-dev libxt-dev libsm-dev libxpm-dev
git clone https://github.com/vim/vim
rm src/auto/config.cache
./configure \
	--with-features=huge \
	--enable-multibyte \
	--enable-python3interp=yes \
	--with-python3-config-dir=/usr/lib/python3.8/config-3.8m-x86_64-linux-gnu \ # check this path	
	--enable-gui=gtk2 \
	--enable-cscope \
	--prefix=/usr/local \
	--with-x 
make
sudo make install
```

Additional setup for vim:
```sh
# copy .vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# run :BundleInstall inside vim
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --clang-completer --cs-completer --go-completer --ts-completer
# ^ ensure deps are met before installing, refer https://github.com/ycm-core/YouCompleteMe
# copy .config/ycm/global_extra_conf.py
cd ~ && mkdir .vim/backup .vim/swap .vim/undo
sudo apt install flake8
```

### Zsh
```sh
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s /bin/zsh
# logout and login
# copy .zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```

### Tmux
```sh
sudo apt install tmux
# copy .tmux.conf
```

### Tilda
```sh
sudo apt install tilda
# copy .config/tilda/config0
```

### homegit alias
```sh
alias homegit='/usr/bin/git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME'
homegit config status.showUntrackedFiles no
```
