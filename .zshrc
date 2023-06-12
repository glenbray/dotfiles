# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

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
plugins=(git git-auto-fetch poetry)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

platform="$(uname | tr '[:upper:]' '[:lower:]')"
projects=""

if [[ $platform == 'linux' ]]; then
  projects=$HOME/Documents/projects
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
  source /opt/conda/etc/profile.d/conda.sh

  export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable
  export ANDROID_HOME=$HOME/Android/Sdk

  # define an open command similar to mac
  open() {
    xdg-open $1 &
  }

  eval $(keychain --eval ~/.ssh/id_ed25519)
elif [[ $platform == 'darwin' ]]; then
  projects=$HOME/Documents/projects
  export ANDROID_HOME=$HOME/Library/Android/sdk
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias p="cd $projects"
alias v="nvim ."
alias vim="nvim"
alias n="nvim ."
alias zc="nvim ~/.zshrc"
alias vc="nvim ~/.config/nvim/init.vim"
alias ss="source ~/.zshrc"
alias h="cd ~/"

alias b="bundle"
alias be="bundle exec"
alias br="bundle exec rspec"
alias bu="bundle update"
alias bo="bundle open"
alias bout="bundle outdated"

alias nb="DEPENDENCIES_NEXT=1 bundle"
alias nbe="DEPENDENCIES_NEXT=1 bundle exec"
alias nbu="DEPENDENCIES_NEXT=1 bundle update"
alias nbo="DEPENDENCIES_NEXT=1 bundle open"
alias nbout="DEPENDENCIES_NEXT=1 bundle outdated"
alias nbr="DEPENDENCIES_NEXT=1 bundle exec rspec"

alias yout="yarn outdated"
alias d="docker-compose"
alias dr="docker-compose run"
alias pip="$(pyenv which pip)"
alias ctags="$(readlink -f $(brew --prefix universal-ctags))/bin/ctags"
alias vimdiff='nvim -d'

source $projects/git/zsh-git-prompt/zshrc.sh

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

export FZF_DEFAULT_COMMAND="rg --files"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PGHOST="/var/pgsql_socket"
export PATH="$PATH:/Users/glen/Documents/flutter/bin"
export PATH="$PATH:$HOME/.local/bin/"

# Android Dev (React native)
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Flutter
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH":"$HOME/Documents/flutter/.pub-cache/bin"
export PATH="$PATH":"$HOME/Documents/flutter/bin/cache/dart-sdk/bin"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export THOR_MERGE="nvim -d"

# Setup python env
export PYENV_ROOT="$HOME/.pyenv"
export PIPENV_PYTHON="$PYENV_ROOT/shims/python"
export PATH="$PYENV_ROOT/bin:$PATH"

export JAVA_HOME=$(/usr/libexec/java_home)

eval "$(rbenv init -)"
eval "$(pyenv init -)"

autoload compinit; compinit; zstyle :completion:\* menu select

# ctrl + home move cursor to beginning of line
bindkey  "^[[H"   beginning-of-line
# ctrl + end move cursor to end of line
bindkey  "^[[F"   end-of-line
# delete key delete char under cursor
bindkey  "^[[3~"  delete-char

precmd() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}

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


# print git related info in prompt
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_LOCAL=""
PROMPT='$(get_prompt)'

eval "$(direnv hook zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

ulimit -n 1024

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
