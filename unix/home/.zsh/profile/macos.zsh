alias ls='gls --color'
alias ll='gls -lh --color'
alias la='gls -lah --color'

alias rm="trash"

export PATH="/usr/local/sbin:$PATH"

export PATH="$HOME/.pyenv/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

alias brew="env PATH=${PATH/$HOME\/\.pyenv\/shims:/} brew"
