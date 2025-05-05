autoload -Uz compinit vcs_info
compinit

zstyle ':completion:*' menu select

bindkey -e

export HISTFILE=${HOME}/.cache/zsh/zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt SHARE_HISTORY

precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '(%b)%F{red}%m%u%c'
zstyle ':vcs_info:*' check-for-changes true

setopt PROMPT_SUBST
PROMPT='%F{green}%n%F{white}@%m %F{cyan}%/ %F{white}%# '
RPROMPT=\$vcs_info_msg_0_

alias x="exit"
alias g="git"
alias grep="grep --color"
alias vi="nvim"
alias ss="sudo systemctl"
alias p="sudo pacman"
alias ls="ls --color=auto"
alias ..="cd ../"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
