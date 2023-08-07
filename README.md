# dotfiles

## Setup config command

- `brew install git`
- `alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'`
- `git clone --bare git@github.com:glenbray/dotfiles.git $HOME/.cfg`
- follow remaining instructions https://www.atlassian.com/git/tutorials/dotfiles

## General

- `(mkdir -p ~/Documents/projects/git && cd "$_" && git clone git@github.com:olivierverdier/zsh-git-prompt.git)`
- `echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> $HOME/.zprofile`
- `brew bundle --no-lock`
- `pyenv install 3.10:latest`
- `sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
- `$(brew --prefix)/opt/fzf/install`


## Postgres setup and pg gem install

- https://postgresapp.com
- `sudo mkdir -p /etc/paths.d && echo /Applications/Postgres.app/Contents/Versions/latest/bin | sudo tee /etc/paths.d/postgresapp`
- `sudo ARCHFLAGS="-arch x86_64" gem install pg`


## Mac configuration

- `defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false` (Disable character variations when holding down key)



## ctags for ruby/rails projects

`ripper-tags -R --exclude=vendor . $(bundle list --paths | sed 's/$/\/lib/')`
