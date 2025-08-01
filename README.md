# Dotfiles

My Dotfiles for Neovim, Tmux, Zsh and Alacritty

![Screenshot](/Pictures/full-setup.png?raw=true)

## Themes/Colorschemes
  * Nvim Colorscheme: Custom theme I built called asteroid - [asteroid.vim](https://github.com/prdx23/asteroid.vim)
  * Nvim Statusline and bufferline: Custom: [statusline.lua](https://github.com/prdx23/dotfiles/blob/master/.config/nvim/lua/statusline.lua)
  * Tmux Colorscheme: Custom theme, also called asteroid - [asteroid.tmux.sh](https://github.com/prdx23/dotfiles/blob/master/.config/tmux/asteroid.tmux.sh)
  * Zsh prompt: [Starship](https://starship.rs/)
  * Font: [JetBrains Mono - Nerd Font](https://www.nerdfonts.com/font-downloads)

## Utils
Shell scripts behind this setup (most of these are probably linux only):

  * [commands.sh](https://github.com/prdx23/dotfiles/blob/master/.config/zsh/commands.sh) - Some useful shell commands like `goto`, `code`, `sr`/`sd` for tmux split right/down, `mkcd` for mkdir+cd, etc.
  * [alacritty_popup_wayland.sh](https://github.com/prdx23/dotfiles/blob/master/.config/zsh/alacritty_popup_wayland.sh) & [alacritty_popup_xorg.sh](https://github.com/prdx23/dotfiles/blob/master/.config/zsh/alacritty_popup_xorg.sh) - Make alacritty into a dropdown terminal
  * [godot_neovide_bridge.sh](https://github.com/prdx23/dotfiles/blob/master/.config/zsh/godot_neovide_bridge.sh) - Bridge script to use neovim as the editor for godot via neovide
  * [spotify.py](https://github.com/prdx23/dotfiles/blob/master/.config/tmux/spotify.py) - Get song, artist and album name from spotify using DBus, accepts params so that they can be colored separately in tmux statusline
  * [battery.sh](https://github.com/prdx23/dotfiles/blob/master/.config/tmux/battery.sh) - Battery capacity with different icons for charging/discharging
  * [uptime.sh](https://github.com/prdx23/dotfiles/blob/master/.config/tmux/uptime.sh) - Nicely formatted uptime
  * [test_24bit_colors.sh](https://github.com/prdx23/dotfiles/blob/master/.config/zsh/test_24bit_colors.sh) - Test if the terminal/tmux support true RGB colors
  * [test_italics_underline.sh](https://github.com/prdx23/dotfiles/blob/master/.config/zsh/test_italics_underline.sh) - Test if the terminal/tmux support italics, underline and undercurl
  * [zen_session_backup.sh](https://github.com/prdx23/dotfiles/blob/master/.config/zsh/zen_session_backup.sh) - Backup specific files in zen browser's profile that maintain current open tabs and session, runs at startup


## First time setup
This is mostly for my personal use but if you are following along this repo, this might help


### Initial setup
```sh
sudo dnf update
sudo dnf install git curl gcc clang make entr ripgrep wl-clipboard fzf jq fd-find bat
git config --global user.email "..."
git config --global user.name "Arsh"
git config --global credential.helper store
# copy .gitignore_global
git config --global core.excludesfile '~/.gitignore_global'
git config --global core.editor nvim
git config --global init.defaultBranch main

sudo dnf install python3-pip
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo dnf install npm
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf <go tar file>
```


### Alacritty
```sh
sudo dnf install alacritty xrandr wmctrl
# copy .config/alacritty/
# set keyboard shortcut for alacritty_popup_wayland.sh/alacritty_popup_xorg.sh
```


### Zsh
```sh
sudo dnf install zsh
chsh -s $(which zsh)
# logout and login
# copy .zshrc and .config/zsh
curl -L git.io/antigen > ~/.config/zsh/antigen.zsh
curl -sS https://starship.rs/install.sh | sh
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
# open nvim and lazy.nvim should install all plugins

# install nvim server
python3 -m pip install --user pipx
python3 -m pipx ensurepath
pipx install 'neovim-remote'
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
