# Dotfiles

My Dotfiles for Vim, Tmux, Zsh and Alacritty

![Screenshot](/Pictures/full-setup.png?raw=true)

## Themes/Colorschemes  
  * Vim Colorscheme: Custom theme i built called turtle - [turtle.vim](https://github.com/prdx23/dotfiles/blob/master/.vim/colors/turtle.vim), [colorscheme source code(estilo)](https://github.com/prdx23/dotfiles/tree/master/utilities/turtle)
  * Vim Statusline: Custom: [statusline.vim](https://github.com/prdx23/dotfiles/blob/master/.vim/plugin/statusline.vim)
  * Tmux Colorscheme: Custom theme, also called turtle - [turtle.tmux.sh](https://github.com/prdx23/dotfiles/blob/master/utilities/turtle.tmux.sh)
  * Zsh prompt: [Spaceship](https://git.io/spaceship)
  * Font: [DejaVu Sans Mono - Nerd Font](https://www.nerdfonts.com/font-downloads)

## Utils  
Shell scripts behind this setup (most of these are probably linux only):  

  * [commands.sh](https://github.com/prdx23/dotfiles/blob/master/utilities/commands.sh) - Some useful shell commands like `sr`, `sd` for tmux split right/down, `mkcd` for mkdir+cd, etc.
  * [alacritty_toggle.sh](https://github.com/prdx23/dotfiles/blob/master/utilities/alacritty_toggle.sh) - Make alacritty into a dropdown terminal
  * [spotify.sh](https://github.com/prdx23/dotfiles/blob/master/utilities/spotify.sh) - Get song, artist and album name from spotify using DBus, accepts params so that they can be colored separately in tmux statusline
  * [battery.sh](https://github.com/prdx23/dotfiles/blob/master/utilities/battery.sh) - Battery capacity with different icons for charging/discharging
  * [uptime.sh](https://github.com/prdx23/dotfiles/blob/master/utilities/uptime.sh) - Nicely formatted uptime
  * [test_24bit_colors.sh](https://github.com/prdx23/dotfiles/blob/master/utilities/test_24bit_colors.sh) - Test if the terminal/tmux support true RGB colors


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
git clone https://github.com/vim/vim # if not present
sudo make uninstall
sudo make distclean
rm src/auto/config.cache
rm auto/config.cache
# remember to check that path for python3-config
./configure \
	--with-features=huge \
	--enable-multibyte \
	--enable-python3interp=dynamic \
	--with-python3-config-dir=/usr/lib/python3.8/config-3.8-x86_64-linux-gnu \
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
# run :PluginInstall inside vim
cd ~/.vim/bundle/YouCompleteMe
sudo env "PATH=$PATH" python3 install.py --clang-completer --cs-completer --go-completer --ts-completer
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

### Alacritty
```sh
sudo add-apt-repository ppa:aslatter/ppa
sudo apt install alacritty
# copy .config/alacritty/alacritty.yml
```

### homegit alias
```sh
alias homegit='/usr/bin/git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME'
homegit config status.showUntrackedFiles no
```
