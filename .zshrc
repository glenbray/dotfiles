# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/glen/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias config='/usr/bin/git --git-dir=/Users/glen/.cfg/ --work-tree=/Users/glen'
alias v="nvim ."
alias vim="nvim"
alias n="nvim ."
alias zc="nvim ~/.zshrc"
alias vc="nvim ~/.vimrc"
alias ss="source ~/.zshrc"
alias p="cd ~/Documents/projects"
alias b="bundle exec"
alias bo="bundle open"
alias bout="bundle outdated"
alias yout="yarn outdated"
alias bi="bundle install"
alias br="bundle exec rspec"
alias d="docker-compose"
alias dr="docker-compose run"
# alias ls="exa"
# alias cat="bat"

source /Users/glen/Documents/projects/git/zsh-git-prompt/zshrc.sh
$(antibody bundle < ~/.zsh_plugins.txt)

# HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# export FZF_DEFAULT_OPTS='--color bg+:#334455'
export FZF_DEFAULT_COMMAND="rg --files"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/Users/glen/.vim/plugged/fzf/bin:$PATH"
export PATH="/Users/glen/.emacs.d/bin:$PATH"
export PGHOST="/var/pgsql_socket"
export PATH="$PATH:/Users/glen/Documents/flutter/bin"

# Android Dev (React native)
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Flutter
export PATH="$PATH":"$HOME/Documents/flutter/.pub-cache/bin"
export PATH="$PATH":"$HOME/Documents/flutter/bin/cache/dart-sdk/bin"

autoload compinit; compinit; zstyle :completion:\* menu select

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

eval "$(rbenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

precmd() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init -)"

get_prompt() {
  echo -n "\n"
  echo -n "%{$reset_color%}"
  echo -n "%{$fg[cyan]%}[%~]" # Dir
  echo -n "$(git_super_status) " # Git branch
  echo -n "\n"
  echo -n "%{$fg_bold[green]%}➜ " # Right arrow
  echo -n "%{$fg[magenta]%}%n%f " # User
  echo -n "at " # at
  echo -n "%{$fg[yellow]%}%m%f " # Host
  echo -n "$%{$reset_color%} " # $
  echo -n "\n"
}


ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_LOCAL=""
PROMPT='$(get_prompt)'

eval "$(direnv hook zsh)"

