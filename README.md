# dotfiles

## Setup config command

https://www.atlassian.com/git/tutorials/dotfiles


## General

- `echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> $HOME/.zprofile`
- `brew install git fzf rbenv pyenv nvm direnv xz overmind ripgrep bat redis yarn libxml2 gh`
- `pyenv install 3.10:latest`
- install python (use pyenv and set global python version)
- `mkdir -p ~/Documents/projects/git && git clone git@github.com:olivierverdier/zsh-git-prompt.git`
- `sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
- `$(brew --prefix)/opt/fzf/install`
- `brew install --cask alt-tab`


## Neovim Setup

- `brew install neovim --HEAD`
- install [vim-plug](https://github.com/junegunn/vim-plug#neovim)
- `brew tap homebrew/cask-fonts`
- `brew install font-fira-mono-nerd-font --cask`


## Postgres setup and pg gem install

- https://postgresapp.com
- `sudo mkdir -p /etc/paths.d && echo /Applications/Postgres.app/Contents/Versions/latest/bin | sudo tee /etc/paths.d/postgresapp`
- `sudo ARCHFLAGS="-arch x86_64" gem install pg`


## Mac configuration

- `defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false` (Disable character variations when holding down key)



## ctags for ruby/rails projects

`ripper-tags -R --exclude=vendor . $(bundle list --paths | sed 's/$/\/lib/')`
