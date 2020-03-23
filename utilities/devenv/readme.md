
Run once
- docker pull alpine

To build the latest version
- docker build -t devenv .

To get a new container with shell
- docker run -it --rm devenv

Remove dangling images
- docker image prune


`docker_vimrc` is a very lightweight version of my vimrc, only keeping:
- undo files in separate folder(no backup or swap files)
- base settings
- keybindings
- statusline not dependent on airline
- colorscheme - directly from git
- nerd commenter - directly from git
- no other external plugins
