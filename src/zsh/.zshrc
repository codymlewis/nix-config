autoload -Uz compinit vcs_info
compinit

zstyle ':completion:*' menu select

bindkey -e

precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '(%b)%F{red}%m%u%c'

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
