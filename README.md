# dotfiles

## Setup config command

https://www.atlassian.com/git/tutorials/dotfiles


## General

- install python (use pyenv and set global python version)
- `brew install pyenv`
- install [antibody](https://github.com/getantibody/antibody)


## Neovim Setup

- `brew install neovim --HEAD`
- install [vim-plug](https://github.com/junegunn/vim-plug#unix)
- `brew install ripgrep`
- `brew tap homebrew/cask-fonts`
- `brew install font-fira-mono-nerd-font --cask`
- `brew install code-minimap`


## Vim prerequisites (deprecated - switched to neovim)

Uninstall vim & reinstall if current version is `< 8.2`

- install [fzf](https://github.com/junegunn/fzf)
- install bat (for syntax colours in ripgrep previews)
- ensure system is using vim 8.2 with python support
- `brew install ripgrep`
- `brew tap homebrew/cask-fonts`
- `brew install font-fira-mono-nerd-font --cask`
- `brew install code-minimap`

## ctags for ruby/rails projects

`ripper-tags -R --exclude=vendor . $(bundle list --paths | sed 's/$/\/lib/')`

