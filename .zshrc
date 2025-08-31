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

if [[ $platform == 'linux' ]]; then
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
  export ANDROID_HOME=$HOME/Library/Android/sdk
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias p="cd $HOME/Documents/projects"
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

alias yout="yarn outdated"
alias d="docker-compose"
alias dr="docker-compose run"
alias pip="$(pyenv which pip)"
alias ctags="$(readlink -f $(brew --prefix universal-ctags))/bin/ctags"
alias vimdiff='nvim -d'

source $HOME/Documents/projects/git/zsh-git-prompt/zshrc.sh

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
# export PGHOST="/var/pgsql_socket"
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

# export JAVA_HOME=$(/usr/libexec/java_home)

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
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"


ulimit -n 1024

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export JAVA_HOME=${SDKMAN_CANDIDATES_DIR}/java/${CURRENT}
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

create-worktree() {
    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "❌ Not a git repository"
        return 1
    fi

    # Check if a name was provided
    if [ $# -eq 0 ]; then
        echo "❌ Usage: create-worktree <worktree-name>"
        echo "📝 Example: create-worktree timeline"
        return 1
    fi

    local NAME="$1"

    # Get current directory name for worktrees directory
    local CURRENT_DIR=$(basename "$(pwd)")
    local WORKTREES_DIR="../${CURRENT_DIR}-worktrees"
    local WORKTREE_DIR="${WORKTREES_DIR}/${NAME}"
    local BRANCH_NAME="${NAME}"

    # Create worktrees directory if it doesn't exist
    if [ ! -d "${WORKTREES_DIR}" ]; then
        mkdir -p "${WORKTREES_DIR}"
        echo "📁 Created worktrees directory: ${WORKTREES_DIR}"
    fi

    # Check if branch already exists
    if git show-ref --verify --quiet refs/heads/"${BRANCH_NAME}"; then
        echo "📋 Creating worktree from existing branch '${BRANCH_NAME}'"
        git worktree add "${WORKTREE_DIR}" "${BRANCH_NAME}" --quiet
    else
        echo "🆕 Creating worktree with new branch '${BRANCH_NAME}'"
        git worktree add "${WORKTREE_DIR}" -b "${BRANCH_NAME}" --quiet
    fi

    if [ $? -eq 0 ]; then
        # Symlink config files

        # Get absolute path to main repo for symlinking
        local MAIN_REPO_ABS=$(pwd)

        # Symlink common config files if they exist
        for file in .env.development .env.test CLAUDE.md; do
            if [ -f "$file" ]; then
                ln -sf "${MAIN_REPO_ABS}/$file" "${WORKTREE_DIR}/$file"
            fi
        done

        # Symlink .claude directory if it exists
        if [ -d ".claude" ]; then
            ln -sf "${MAIN_REPO_ABS}/.claude" "${WORKTREE_DIR}/.claude"
        fi


        # Copy example files if the actual files don't exist
        if [ ! -f "${WORKTREE_DIR}/.env.development" ] && [ -f ".env.development.example" ]; then
            cp ".env.development.example" "${WORKTREE_DIR}/.env.development"
        fi

        if [ ! -f "${WORKTREE_DIR}/.env.test" ] && [ -f ".env.test.example" ]; then
            cp ".env.test.example" "${WORKTREE_DIR}/.env.test"
        fi

        echo "✅ Worktree created: ${WORKTREE_DIR}"
        cd "${WORKTREE_DIR}"
    else
        echo "❌ Failed to create worktree"
        return 1
    fi
}

remove-worktree() {
    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "❌ Not a git repository"
        return 1
    fi

    local NAME=""
    local CURRENT_DIR_NAME=$(basename "$(pwd)")
    local REPO_NAME=""

    # Try to determine repository name
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        # If we're in a worktree, get the main repo name from git worktree list
        local WORKTREE_LIST=$(git worktree list)
        local MAIN_REPO_PATH=$(echo "$WORKTREE_LIST" | head -1 | awk '{print $1}')
        REPO_NAME=$(basename "$MAIN_REPO_PATH")
    fi

    local WORKTREES_DIR="../${REPO_NAME}-worktrees"

    if [ $# -eq 0 ]; then
        # Try to auto-detect if we're in a worktree directory
        local CURRENT_DIR=$(pwd)
        if [[ "$CURRENT_DIR" == *"${REPO_NAME}-worktrees"* ]]; then
            NAME="$CURRENT_DIR_NAME"
            echo "🔍 Auto-detected worktree: $NAME"
            echo "📁 Current directory: $(pwd)"
        else
            echo "❌ Usage: remove-worktree <worktree-name>"
            echo "📝 Example: remove-worktree timeline"
            echo "💡 Or run from within a worktree directory to auto-remove"
            echo "📋 List all worktrees: git worktree list"
            return 1
        fi
    else
        NAME="$1"
    fi

    # If we're inside a worktree directory, use the current directory
    local CURRENT_DIR=$(pwd)
    if [[ "$CURRENT_DIR" == *"${REPO_NAME}-worktrees/${NAME}" ]]; then
        local WORKTREE_DIR="$CURRENT_DIR"
    else
        local WORKTREE_DIR="${WORKTREES_DIR}/${NAME}"
    fi
    local BRANCH_NAME="${NAME}"

    # Check if worktree exists
    if [ ! -d "${WORKTREE_DIR}" ]; then
        echo "❌ Worktree directory ${WORKTREE_DIR} does not exist!"
        return 1
    fi

    # Check if we're currently in the worktree being removed and change directory FIRST
    local CURRENT_DIR=$(pwd)
    local WORKTREE_ABS_PATH=$(cd "${WORKTREE_DIR}" && pwd 2>/dev/null)
    local NEED_TO_CHANGE_DIR=false
    local MAIN_REPO_DIR=""

    if [[ "${CURRENT_DIR}" == "${WORKTREE_ABS_PATH}"* ]]; then
        NEED_TO_CHANGE_DIR=true
        # When inside a worktree, we need to go up 2 levels to get to main repo
        MAIN_REPO_DIR="../../${REPO_NAME}"
        echo "📂 Changing to main repository: ${MAIN_REPO_DIR}"
        cd "${MAIN_REPO_DIR}"
    fi

    # Check if branch is merged into main
    local DELETE_BRANCH=false
    local IS_MERGED=false

    # Switch to main branch to check if current branch is merged
    local CURRENT_BRANCH=$(git branch --show-current)
    git checkout main > /dev/null 2>&1 || git checkout master > /dev/null 2>&1

    if git merge-base --is-ancestor "${BRANCH_NAME}" HEAD 2>/dev/null; then
        IS_MERGED=true
        echo "✅ Branch '${BRANCH_NAME}' is merged, will delete automatically"
        DELETE_BRANCH=true
    else
        read "REPLY?🗑️  Delete unmerged branch '${BRANCH_NAME}'? (y/N): "
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            DELETE_BRANCH=true
        fi
    fi

    # Remove the worktree
    git worktree remove "${WORKTREE_DIR}" --force > /dev/null 2>&1

    # Delete the branch if requested
    if [ "$DELETE_BRANCH" = true ]; then
        git branch -D "${BRANCH_NAME}" > /dev/null 2>&1
        if [ "$IS_MERGED" = true ]; then
            echo "✅ Removed worktree and deleted merged branch '${BRANCH_NAME}'"
        else
            echo "✅ Removed worktree and deleted branch '${BRANCH_NAME}'"
        fi
    else
        echo "✅ Removed worktree, kept branch '${BRANCH_NAME}'"
    fi

    # Final directory check and git command
    if [ "$NEED_TO_CHANGE_DIR" = true ]; then
        # We should already be in the main repo from the earlier cd command
        echo "📂 Now in: $(pwd)"
    fi

    echo "📋 Remaining worktrees:"
    git worktree list
}

# Test function to see if cd works
test-cd() {
    echo "Before: $(pwd)"
    cd ..
    echo "After: $(pwd)"
}


export PATH="$HOME/.local/bin:$PATH"

export ANTHROPIC_MODEL="claude-sonnet-4-20250514"
