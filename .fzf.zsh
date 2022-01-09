# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

if [[ $platform == 'linux' ]]; then
  # source $HOME/projects/git/zsh-git-prompt/zshrc.sh
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
elif [[ $platform == 'darwin' ]]; then
  source $HOME/Documents/projects/git/zsh-git-prompt/zshrc.sh
  # Auto-completion
  # ---------------
  [[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

  # Key bindings
  # ------------
  source "/usr/local/opt/fzf/shell/key-bindings.zsh"
fi


