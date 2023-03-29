# Dotfiles

My Dotfiles for Vim, Tmux, Zsh and Alacritty

![Screenshot](/Pictures/full-setup.png?raw=true)

## Themes/Colorschemes  
  * Nvim Colorscheme: Custom theme i built called asteroid - [asteroid.vim](https://github.com/prdx23/asteroid.vim)
  * Nvim Statusline and bufferline: Custom: [statusline.vim](https://github.com/prdx23/dotfiles/blob/master/.config/nvim/plugin/statusline.vim) & [bufferline.vim](https://github.com/prdx23/dotfiles/blob/master/.config/nvim/plugin/bufferline.vim)
  * Tmux Colorscheme: Custom theme, also called asteroid - [asteroid.tmux.sh](https://github.com/prdx23/dotfiles/blob/master/.config/tmux/asteroid.tmux.sh)
  * Zsh prompt: [Spaceship](https://git.io/spaceship)
  * Font: [DejaVu Sans Mono - Nerd Font](https://www.nerdfonts.com/font-downloads)

## Utils  
Shell scripts behind this setup (most of these are probably linux only):  

  * [commands.sh](https://github.com/prdx23/dotfiles/blob/master/.config/zsh/commands.sh) - Some useful shell commands like `sr`, `sd` for tmux split right/down, `mkcd` for mkdir+cd, etc.
  * [alacritty_popup_wayland.sh](https://github.com/prdx23/dotfiles/blob/master/.config/zsh/alacritty_popup_wayland.sh) & [alacritty_popup_xorg.sh](https://github.com/prdx23/dotfiles/blob/master/.config/zsh/alacritty_popup_xorg.sh) - Make alacritty into a dropdown terminal
  * [spotify.sh](https://github.com/prdx23/dotfiles/blob/master/.config/tmux/spotify.sh) - Get song, artist and album name from spotify using DBus, accepts params so that they can be colored separately in tmux statusline
  * [battery.sh](https://github.com/prdx23/dotfiles/blob/master/.config/tmux/battery.sh) - Battery capacity with different icons for charging/discharging
  * [uptime.sh](https://github.com/prdx23/dotfiles/blob/master/.config/tmux/uptime.sh) - Nicely formatted uptime
  * [test_24bit_colors.sh](https://github.com/prdx23/dotfiles/blob/master/.config/zsh/test_24bit_colors.sh) - Test if the terminal/tmux support true RGB colors


## First time setup  
This is mostly for my personal use but if you are following along this repo, this might help


### Initial setup
```sh
sudo dnf update
sudo dnf install git curl gcc clang make ripgrep wl-clipboard
git config --global user.email "..."
git config --global user.name "Arsh"
git config --global credential.helper store
# copy .gitignore_global
git config --global core.excludesfile '~/.gitignore_global'
git config --global core.editor nvim
git config --global init.defaultBranch main

sudo dnf install python3-pip
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf <go tar file>
```


### Alacritty
```sh
sudo dnf install alacritty jq xrandr wmctrl
# copy .config/alacritty/
# set keyboard shortcut for alacritty_popup_wayland.sh/alacritty_popup_xorg.sh
```


### Zsh
```sh
sudo dnf install zsh entr
chsh -s $(which zsh)
# logout and login
# copy .zshrc and .config/zsh
curl -L git.io/antigen > ~/.config/zsh/antigen.zsh
```


### Neovim
I compile nvim to use the latest stable
```sh
sudo dnf install ninja-build libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip patch gettext curl

cd Code/source
git clone https://github.com/neovim/neovim
cd neovim
git checkout <version>
# or do - git checkout stable
make distclean
make CMAKE_BUILD_TYPE=Release
sudo make install

# copy .config/nvim
# install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# open nvim and run :PlugInstall then run :LspInstall

# install nvim server
python3 -m pip install --user pipx
python3 -m pipx ensurepath
pipx install 'neovim-remote'

# hexokinase plugin setup
cd ~/.local/share/nvim/plugged/vim-hexokinase
make hexokinase
```


### Tmux
```sh
sudo dnf install tmux
# copy .tmux.conf and .config/tmux
```

### homegit alias
```sh
cd ~ && mkdir dotfiles
alias homegit='/usr/bin/git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME'
homegit init
homegit config status.showUntrackedFiles no
homegit remote add origin https://github.com/prdx23/dotfiles.git
homegit pull origin master
homegit checkout master
```
