# dotfiles

### Vim prerequisites

- install python (use pyenv and set global python version)
- install fzf
- install ripgrep (fast search)
- install bat (for syntax colours in ripgrep previews)
- ensure system is using vim 8.2 with python support

(uninstall vim if vim is < 8.2)
```shell
$ sudo add-apt-repository ppa:jonathonf/vim
$ sudo apt install vim
$ sudo apt install vim-gtk3 vim-nox
```

### ctags for ruby/rails projects

`ripper-tags -R --exclude=vendor . $(bundle list --paths | sed 's/$/\/lib/')`

