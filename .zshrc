# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Performance: disable expensive oh-my-zsh features before sourcing
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"
DISABLE_AUTO_TITLE="true"
ZSH_THEME="robbyrussell"

plugins=(fzf-tab git git-auto-fetch zsh-autosuggestions)

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
alias pip='${PYENV_ROOT}/shims/pip'
alias ctags='/opt/homebrew/opt/universal-ctags/bin/ctags'
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
setopt AUTO_CD                   # Type a directory name to cd into it.

export FZF_DEFAULT_COMMAND="rg --files"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$PATH:$HOME/Documents/flutter/bin"
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
export PATH="/usr/local/sbin:$PATH"

export THOR_MERGE="nvim -d"

# Setup python env
export PYENV_ROOT="$HOME/.pyenv"
export PIPENV_PYTHON="$PYENV_ROOT/shims/python"
export PATH="$PYENV_ROOT/bin:$PATH"

export PATH="$HOME/.deno/bin:$PATH"

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

zstyle ':completion:*' menu select

_rspec_files() {
  local -a files
  files=(${(f)"$(rg --files -g '*_spec.rb' 2>/dev/null)"})
  compadd -a files
}

# RSpec completion
_rspec() {
  local -a opts
  opts=(
    '--help[Show this message]'
    '--version[Show version]'
    '--init[Initialize your project with RSpec]'
    '--pattern[Load files matching pattern (default: "spec/**/*_spec.rb")]'
    '--exclude-pattern[Load files except those matching pattern]'
    '--require[Require a file]:file:_files'
    '-I[Specify PATH to add to $LOAD_PATH]:path:_directories'
    '--default-path[Set the default path where RSpec looks for examples]:path:_directories'
    '--order[Run examples by the specified order type]:order:(defined rand random recently-modified)'
    '--seed[Equivalent of --order rand:SEED]:seed:'
    '--bisect[Repeatedly runs the suite to isolate failures]'
    '--fail-fast[Abort after a certain number of failures]:count:'
    '--no-fail-fast[Disable fail fast]'
    '--next-failure[Apply `--only-failures` and abort after one failure]'
    '--only-failures[Filter to examples that failed the last time they ran]'
    '--no-error-on-unmatched-pattern[Prevent non-zero exit status when no examples match the pattern]'
    '--format[Choose a formatter]:format:(progress documentation html json)'
    '--colour[Enable colour in the output]'
    '--color[Enable color in the output]'
    '--no-colour[Disable colour in the output]'
    '--no-color[Disable color in the output]'
    '--profile[Enable profiling of examples and list the slowest examples]:count:'
    '--no-profile[Disable profiling of examples]'
    '--backtrace[Enable full backtrace]'
    '--no-backtrace[Disable backtrace]'
    '--clean-backtrace[Clean up the backtrace]'
    '--no-clean-backtrace[Disable clean backtrace]'
    '--warnings[Enable ruby warnings]'
    '--no-warnings[Disable ruby warnings]'
    '--tag[Run examples with the specified tag]:tag:'
    '-t[Run examples with the specified tag]:tag:'
    '--dry-run[Print the formatter output of your suite without running examples]'
    '--deprecation-out[Direct deprecation warnings to a file]:file:_files'
  )

  _arguments -s $opts '*:spec file:_rspec_files'
}

compdef _rspec rspec
compdef _rspec br

# Bundle exec completion wrapper
_bundle_exec_rspec() {
  if [[ ${words[2]} == "exec" ]] && [[ ${words[3]} == "rspec" ]]; then
    words=(rspec "${words[@]:3}")
    (( CURRENT -= 2 ))
    _rspec
  fi
}

compdef '_bundle_exec_rspec' bundle

# ctrl + home move cursor to beginning of line
bindkey  "^[[H"   beginning-of-line
# ctrl + end move cursor to end of line
bindkey  "^[[F"   end-of-line
# delete key delete char under cursor
bindkey  "^[[3~"  delete-char

precmd() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
  # Tell iTerm2 the current directory (enables split pane to inherit pwd)
  echo -ne "\033]1337;CurrentDir=${PWD}\007"
  # Report CWD to Ghostty (needed for split pane directory inheritance)
  print -n "\e]7;file://${HOST}${PWD}\a" > /dev/tty
}

eval "$(starship init zsh)"


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

ulimit -n 64000 2>/dev/null || ulimit -n 10240 2>/dev/null || true
ulimit -u 2048 2>/dev/null || true

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export JAVA_HOME=${SDKMAN_CANDIDATES_DIR}/java/${CURRENT}
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

create-worktree() {
    # Help flag
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        echo "Usage: create-worktree <dir-name> [branch-name] [base-branch]"
        echo ""
        echo "Arguments:"
        echo "  dir-name     Directory name for the worktree (required)"
        echo "  branch-name  Git branch name (defaults to dir-name)"
        echo "  base-branch  Branch to base the new branch on (defaults to 'main')"
        echo ""
        echo "Examples:"
        echo "  create-worktree timeline"
        echo "      → Creates dir 'timeline', branch 'timeline', based on 'main'"
        echo ""
        echo "  create-worktree my-dir feature/timeline"
        echo "      → Creates dir 'my-dir', branch 'feature/timeline', based on 'main'"
        echo ""
        echo "  create-worktree my-dir feature/timeline develop"
        echo "      → Creates dir 'my-dir', branch 'feature/timeline', based on 'develop'"
        return 0
    fi

    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "❌ Not a git repository"
        return 1
    fi

    # Check if a name was provided
    if [ $# -eq 0 ]; then
        echo "❌ Usage: create-worktree <dir-name> [branch-name] [base-branch]"
        echo "💡 Run 'create-worktree --help' for more info"
        return 1
    fi

    local NAME="$1"
    local BRANCH_NAME="${2:-$NAME}"  # Use $2 if provided, otherwise default to $NAME
    local BASE_BRANCH="${3:-main}"   # Use $3 if provided, otherwise default to main

    # Get current directory name for worktrees directory
    local CURRENT_DIR=$(basename "$(pwd)")
    local WORKTREES_DIR="../${CURRENT_DIR}-worktrees"
    local WORKTREE_DIR="${WORKTREES_DIR}/${NAME}"

    # Create worktrees directory if it doesn't exist
    if [ ! -d "${WORKTREES_DIR}" ]; then
        mkdir -p "${WORKTREES_DIR}"
        echo "📁 Created worktrees directory: ${WORKTREES_DIR}"
    fi

    # Fetch latest changes from remote
    echo "🔄 Fetching latest changes..."
    git fetch --quiet

    # Check if branch already exists
    if git show-ref --verify --quiet refs/heads/"${BRANCH_NAME}"; then
        echo "📋 Creating worktree from existing branch '${BRANCH_NAME}'"

        # Check if remote branch exists and update local branch
        if git show-ref --verify --quiet refs/remotes/origin/"${BRANCH_NAME}"; then
            echo "🔄 Updating local branch to match remote..."
            git branch --set-upstream-to=origin/"${BRANCH_NAME}" "${BRANCH_NAME}" 2>/dev/null || true
            git checkout "${BRANCH_NAME}" --quiet
            git pull --quiet || echo "⚠️  Could not fast-forward ${BRANCH_NAME}, creating worktree with current state"
            git checkout - --quiet
        fi

        git worktree add "${WORKTREE_DIR}" "${BRANCH_NAME}" --quiet
    else
        # Fetch latest from remote to ensure we have up-to-date base branch
        git fetch origin "${BASE_BRANCH}" --quiet 2>/dev/null || true

        echo "🆕 Creating worktree with new branch '${BRANCH_NAME}' based on '${BASE_BRANCH}'"
        git worktree add "${WORKTREE_DIR}" -b "${BRANCH_NAME}" "origin/${BASE_BRANCH}" --quiet
    fi

    if [ $? -eq 0 ]; then
        symlink-worktree "${WORKTREE_DIR}"

        # Copy MCP servers from main repo to new worktree in ~/.claude.json
        local CLAUDE_JSON="$HOME/.claude.json"
        if [ -f "$CLAUDE_JSON" ] && command -v jq &> /dev/null; then
            local WORKTREE_ABS_PATH=$(cd "${WORKTREE_DIR}" && pwd)
            local MCP_SERVERS=$(jq -r --arg path "$MAIN_REPO_ABS" '.projects[$path].mcpServers // {}' "$CLAUDE_JSON")

            if [ "$MCP_SERVERS" != "{}" ] && [ "$MCP_SERVERS" != "null" ]; then
                # Check if worktree project entry exists
                local HAS_PROJECT=$(jq -r --arg path "$WORKTREE_ABS_PATH" 'has("projects") and (.projects | has($path))' "$CLAUDE_JSON")

                if [ "$HAS_PROJECT" = "true" ]; then
                    # Update existing project entry with MCP servers
                    local TEMP_FILE=$(mktemp)
                    jq --arg path "$WORKTREE_ABS_PATH" --argjson mcpServers "$MCP_SERVERS" \
                        '.projects[$path].mcpServers = $mcpServers' "$CLAUDE_JSON" > "$TEMP_FILE" && \
                        mv "$TEMP_FILE" "$CLAUDE_JSON"
                    echo "🔌 Copied MCP servers to worktree config"
                else
                    # Create new project entry with MCP servers
                    local TEMP_FILE=$(mktemp)
                    jq --arg path "$WORKTREE_ABS_PATH" --argjson mcpServers "$MCP_SERVERS" \
                        '.projects[$path] = {"allowedTools": [], "mcpContextUris": [], "mcpServers": $mcpServers, "enabledMcpjsonServers": [], "disabledMcpjsonServers": [], "hasTrustDialogAccepted": true}' "$CLAUDE_JSON" > "$TEMP_FILE" && \
                        mv "$TEMP_FILE" "$CLAUDE_JSON"
                    echo "🔌 Created worktree config with MCP servers"
                fi
            fi
        fi

        echo "✅ Worktree created: ${WORKTREE_DIR}"
        cd "${WORKTREE_DIR}"
    else
        echo "❌ Failed to create worktree"
        return 1
    fi
}

symlink-worktree() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "❌ Not a git repository"
        return 1
    fi

    local MAIN_REPO_ABS
    local WORKTREE_DIR

    if [ -n "$1" ]; then
        MAIN_REPO_ABS=$(pwd)
        WORKTREE_DIR="$1"
    else
        MAIN_REPO_ABS=$(git worktree list | head -1 | awk '{print $1}')
        WORKTREE_DIR=$(pwd)

        if [ "$MAIN_REPO_ABS" = "$WORKTREE_DIR" ]; then
            echo "❌ You're in the main repo. Run from a worktree, or pass a worktree path."
            echo "📝 Usage: symlink-worktree [worktree-path]"
            return 1
        fi
    fi

    if [ ! -d "$WORKTREE_DIR" ]; then
        echo "❌ Directory does not exist: $WORKTREE_DIR"
        return 1
    fi

    local CONFIG="${MAIN_REPO_ABS}/.worktree-symlinks"
    if [ ! -f "$CONFIG" ]; then
        echo "❌ No .worktree-symlinks file found in ${MAIN_REPO_ABS}"
        echo "📝 Create one with file/dir paths to symlink (one per line, supports **/ globs)"
        return 1
    fi

    while IFS= read -r entry || [ -n "$entry" ]; do
        [[ -z "$entry" || "$entry" == \#* ]] && continue

        if [[ "$entry" == **/* ]]; then
            # Glob pattern — find matching files
            while IFS= read -r match; do
                local rel_path="${match#${MAIN_REPO_ABS}/}"
                local target_dir="${WORKTREE_DIR}/$(dirname "$rel_path")"
                if git -C "${MAIN_REPO_ABS}" ls-files --error-unmatch "$rel_path" >/dev/null 2>&1; then
                    echo "⚠️  Skipping $rel_path (tracked in Git)"
                elif [ -L "${WORKTREE_DIR}/$rel_path" ]; then
                    echo "✓ $rel_path (already symlinked)"
                else
                    mkdir -p "$target_dir"
                    ln -sf "${MAIN_REPO_ABS}/$rel_path" "${WORKTREE_DIR}/$rel_path"
                    echo "🔗 $rel_path"
                fi
            done < <(find "${MAIN_REPO_ABS}" -name "$(basename "$entry")" -not -path "*/node_modules/*" -not -path "*/.git/*")
        elif [ -e "${MAIN_REPO_ABS}/${entry}" ]; then
            if git -C "${MAIN_REPO_ABS}" ls-files --error-unmatch "$entry" >/dev/null 2>&1; then
                echo "⚠️  Skipping $entry (tracked in Git)"
            elif [ -L "${WORKTREE_DIR}/${entry}" ]; then
                echo "✓ $entry (already symlinked)"
            else
                ln -sf "${MAIN_REPO_ABS}/${entry}" "${WORKTREE_DIR}/${entry}"
                echo "🔗 $entry"
            fi
        fi
    done < "$CONFIG"

    echo "✅ Symlinks applied to ${WORKTREE_DIR}"
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

eval "$(direnv hook zsh)"

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/Applications/RubyMine.app/Contents/MacOS:$PATH"

# Re-prioritize rbenv shims after homebrew setup
export PATH="$HOME/.rbenv/shims:$PATH"

source ~/.config/zsh/tab-colors.zsh

# Use vi keybindings for command-line editing (Esc to enter normal mode)
set -o vi

# OrbStack
export PATH="$HOME/.orbstack/bin:$PATH"

# bun completions - lazy loaded on first use
bun() {
  unfunction bun
  [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
  command bun "$@"
}

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
