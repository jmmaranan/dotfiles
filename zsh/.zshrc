export ZSH="/home/jmmaranan/.oh-my-zsh"

ZSH_THEME="eastwood"

plugins=(
  git
  golang
  docker
  ssh-agent
  kubectl
  z
  rust
  pyenv
  command-not-found
  fzf
)

source $ZSH/oh-my-zsh.sh

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

