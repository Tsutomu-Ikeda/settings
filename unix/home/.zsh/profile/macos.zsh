alias ls='gls --color'
alias ll='gls -lh --color'
alias la='gls -lah --color'

alias rm="trash"

path=(
  /opt/homebrew/bin(N-/)
  /usr/local/sbin(N-/)
  $HOME/.pyenv/bin(N-/)
  $path
)
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

alias brew="arch -arch x86_64 env PATH=${PATH/$HOME\/\.pyenv\/shims:/} /usr/local/bin/brew"
