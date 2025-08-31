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
alias c="cd $HOME/Documents/projects/camplify/chl"
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

# Commented out slow git prompt - using fast vcs_info instead
# source $HOME/Documents/projects/git/zsh-git-prompt/zshrc.sh

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

# Rbenv - add shims to PATH without loading rbenv
export PATH="$HOME/.rbenv/shims:$PATH"
# Lazy load rbenv
rbenv() {
  unfunction rbenv
  eval "$(command rbenv init - --no-rehash)"
  rbenv "$@"
}

# Pyenv - add shims to PATH without loading pyenv
export PATH="$PYENV_ROOT/shims:$PATH"
# Lazy load pyenv
pyenv() {
  unfunction pyenv
  eval "$(command pyenv init - --no-rehash)"
  pyenv "$@"
}

autoload compinit; compinit; zstyle :completion:\* menu select

# ctrl + home move cursor to beginning of line
bindkey  "^[[H"   beginning-of-line
# ctrl + end move cursor to end of line
bindkey  "^[[F"   end-of-line
# delete key delete char under cursor
bindkey  "^[[3~"  delete-char

# Disable Oh My Zsh's slow terminal title features
DISABLE_AUTO_TITLE="true"

precmd() {
  # sets the tab title to current dir (fast version)
  echo -ne "\e]1;${PWD##*/}\a"
  # Call vcs_info for git status
  vcs_info
}

get_prompt() {
  echo -n "\n"
  echo -n "%{$reset_color%}"
  echo -n "%{$fg[cyan]%}[%~]" # Dir
  echo -n " ${vcs_info_msg_0_} " # Git branch (fast)
  echo -n "\n"
  echo -n "%{$fg_bold[green]%}➜ " # Right arrow
  echo -n "%{$fg[magenta]%}%n%f " # User
  echo -n "at " # at
  echo -n "%{$fg[yellow]%}%m%f " # Host
  echo -n "$%{$reset_color%} " # $
  echo -n "\n"
}


# FAST GIT STATUS - Replace slow python script with built-in vcs_info
autoload -Uz vcs_info
setopt prompt_subst

# Enable git in vcs_info
zstyle ':vcs_info:*' enable git

# Check for untracked files
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '%F{red}●%f'
zstyle ':vcs_info:git:*' stagedstr '%F{yellow}●%f'

# Format when not in action (normal operation)
zstyle ':vcs_info:git:*' formats '(%F{magenta}%b%f%c%u|%m)'
# Format when in action (merge, rebase, etc)
zstyle ':vcs_info:git:*' actionformats '(%F{magenta}%b%f%c%u|%F{red}%a%f)'

# Hook to check remote status
zstyle ':vcs_info:git*+set-message:*' hooks git-st
function +vi-git-st() {
    local ahead behind
    local -a gitstatus

    # Check for commits ahead/behind upstream
    ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null)
    behind=$(git rev-list --count HEAD..@{u} 2>/dev/null)

    if [[ -n $ahead ]] && [[ $ahead -gt 0 ]]; then
        gitstatus+=("%F{green}↑${ahead}%f")
    fi
    if [[ -n $behind ]] && [[ $behind -gt 0 ]]; then
        gitstatus+=("%F{red}↓${behind}%f")
    fi

    # Check if there are any staged or unstaged changes
    local has_changes=false
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
        has_changes=true
    fi

    if [[ ${#gitstatus[@]} -eq 0 ]]; then
        if [[ $has_changes == false ]]; then
            hook_com[misc]="%F{green}✔%f"
        else
            hook_com[misc]="%F{blue}~%f"
        fi
    else
        hook_com[misc]="${(j:/:)gitstatus}"
    fi
}

PROMPT='$(get_prompt)'

eval "$(direnv hook zsh)"

# NVM lazy loading - but keep npm binaries in PATH
export NVM_DIR="$HOME/.nvm"
# Add default node version to PATH without loading nvm
if [ -d "$NVM_DIR/versions/node" ]; then
  # Find the default node version
  DEFAULT_NODE_VERSION=$(cat "$NVM_DIR/alias/default" 2>/dev/null || echo "")
  if [ -n "$DEFAULT_NODE_VERSION" ]; then
    # Add 'v' prefix if not present
    [[ "$DEFAULT_NODE_VERSION" != v* ]] && DEFAULT_NODE_VERSION="v$DEFAULT_NODE_VERSION"
    export PATH="$NVM_DIR/versions/node/$DEFAULT_NODE_VERSION/bin:$PATH"
  else
    # If no default, use the latest installed version
    LATEST_NODE=$(ls -1 "$NVM_DIR/versions/node" | sort -V | tail -1)
    [ -n "$LATEST_NODE" ] && export PATH="$NVM_DIR/versions/node/$LATEST_NODE/bin:$PATH"
  fi
fi

# Only lazy load nvm itself
nvm() {
  unfunction nvm
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  nvm "$@"
}

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

    # Get current directory name and create prefix
    local CURRENT_DIR=$(basename "$(pwd)")
    local PREFIX=""

    # Convert directory name to prefix (first letter of each word)
    if [[ "$CURRENT_DIR" == *"_"* ]]; then
        # Handle underscore-separated words (e.g., intelligen_app -> ia)
        PREFIX=$(echo "$CURRENT_DIR" | sed 's/_/ /g' | awk '{for(i=1;i<=NF;i++) printf substr($i,1,1)}')
    elif [[ "$CURRENT_DIR" == *"-"* ]]; then
        # Handle hyphen-separated words (e.g., intelligen-optimiser -> io)
        PREFIX=$(echo "$CURRENT_DIR" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) printf substr($i,1,1)}')
    else
        # Single word, take first two characters
        PREFIX=$(echo "$CURRENT_DIR" | cut -c1-2)
    fi

    # Extract the last part after final slash for directory name, keep full name for branch
    local DIR_NAME="${NAME##*/}"
    local WORKTREE_DIR="../${PREFIX}-${DIR_NAME}"
    local BRANCH_NAME="${NAME}"


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
        for file in .env .env.development .env.test CLAUDE.md; do
            if [ -f "$file" ]; then
                # Check if file is tracked in Git
                if git ls-files --error-unmatch "$file" >/dev/null 2>&1; then
                    echo "⚠️  Skipping symlink for $file (already tracked in Git)"
                else
                    ln -sf "${MAIN_REPO_ABS}/$file" "${WORKTREE_DIR}/$file"
                fi
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
    local PREFIX=""

    # Get current directory name and create prefix
    local CURRENT_DIR_NAME=$(basename "$(pwd)")
    local REPO_NAME=""

    # Try to determine repository name and prefix
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        # If we're in a worktree, get the main repo name from git worktree list
        local WORKTREE_LIST=$(git worktree list)
        local MAIN_REPO_PATH=$(echo "$WORKTREE_LIST" | head -1 | awk '{print $1}')
        REPO_NAME=$(basename "$MAIN_REPO_PATH")

        # Convert repository name to prefix
        if [[ "$REPO_NAME" == *"_"* ]]; then
            PREFIX=$(echo "$REPO_NAME" | sed 's/_/ /g' | awk '{for(i=1;i<=NF;i++) printf substr($i,1,1)}')
        elif [[ "$REPO_NAME" == *"-"* ]]; then
            PREFIX=$(echo "$REPO_NAME" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) printf substr($i,1,1)}')
        else
            PREFIX=$(echo "$REPO_NAME" | cut -c1-2)
        fi
    fi

    if [ $# -eq 0 ]; then
        # Try to auto-detect if we're in a worktree
        if [[ "$CURRENT_DIR_NAME" == ${PREFIX}-* ]]; then
            NAME="${CURRENT_DIR_NAME#${PREFIX}-}"
            echo "🔍 Auto-detected worktree: $NAME"
            echo "📁 Current directory: $(pwd)"
        else
            echo "❌ Usage: remove-worktree <worktree-name>"
            echo "📝 Example: remove-worktree timeline"
            echo "💡 Or run from within a worktree directory (${PREFIX}-*) to auto-remove"
            echo "📋 List all worktrees: git worktree list"
            return 1
        fi
    else
        NAME="$1"
    fi

    # Extract the last part after final slash for directory name, keep full name for branch
    local DIR_NAME="${NAME##*/}"
    local WORKTREE_DIR="../${PREFIX}-${DIR_NAME}"
    local BRANCH_NAME="${NAME}"


    # Check if worktree exists
    if [ ! -d "${WORKTREE_DIR}" ]; then
        echo "❌ Worktree directory ${WORKTREE_DIR} does not exist!"
        return 1
    fi

    # Check if we're currently in the worktree being removed and change directory FIRST
    local CURRENT_DIR=$(pwd)
    local WORKTREE_ABS_PATH=$(cd "${WORKTREE_DIR}" && pwd 2>/dev/null)

    if [[ "${CURRENT_DIR}" == "${WORKTREE_ABS_PATH}"* ]]; then
        # Find the main repo by going up from the worktree directory
        local MAIN_REPO_DIR=$(dirname "${WORKTREE_DIR}")/${REPO_NAME}
        cd "${MAIN_REPO_DIR}" > /dev/null 2>&1
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

    # Change directory if we were in the removed worktree
    if [[ "${CURRENT_DIR}" == "${WORKTREE_ABS_PATH}"* ]]; then
        local MAIN_REPO_DIR=$(dirname "${WORKTREE_DIR}")/${REPO_NAME}
        # Try to disable direnv temporarily
        export DIRENV_DISABLE=1
        cd "$MAIN_REPO_DIR" 2>/dev/null
        unset DIRENV_DISABLE
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

eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/Applications/RubyMine.app/Contents/MacOS:$PATH"
export PATH="$HOME/.local/bin:$PATH"
