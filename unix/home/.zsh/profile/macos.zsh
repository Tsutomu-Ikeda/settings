alias ls='gls --color'
alias ll='gls -lh --color'
alias la='gls -lah --color'
alias pbcopy='ruby -e "print(\$stdin.read.chomp)" | pbcopy'

path=(
  /opt/homebrew/bin(N-/)
  /opt/homebrew/sbin(N-/)
  /opt/homebrew/opt/mysql-client/bin(N-/)
  /opt/homebrew/opt/libpq/bin(N-/)
  /usr/local/sbin(N-/)
  /usr/local/opt/mysql-client/bin(N-/)
  /usr/local/opt/libpq/bin(N-/)
  $HOME/.pyenv/shims(N-/)
  $HOME/.rbenv/bin(N-/)
  $HOME/go/bin/(N-/)
  $path
)

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if command -v rbenv 1>/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

if command -v nodenv 1>/dev/null 2>&1; then
  eval "$(nodenv init -)"
fi

alias brew="arch -arch x86_64 env PATH=${${PATH/$HOME\/\.pyenv\/shims:/}/\/opt\/homebrew\/bin:/} /usr/local/bin/brew"
alias copy_current_branch="git rev-parse --abbrev-ref HEAD | pbcotee"

function pbcotee() {
  pbcopy && pbpaste
}

function aws-local {
  local cmd=$1

  if [ "$cmd" = "s3" -o "$cmd" = "s3api" ]; then
    AWS_ACCESS_KEY_ID=hogehoge AWS_SECRET_ACCESS_KEY=fugafuga aws --endpoint-url=http://localhost:9000 "$@"
  elif [ "$cmd" = "stepfunctions" ]; then
    aws --endpoint-url=http://localhost:8083/ "$@"
  elif [ "$cmd" = "glue" -o "$cmd" = "ecs" -o "$cmd" = "events" ]; then
    aws --endpoint-url=http://localhost:9999/$cmd/ "$@"
  else
    aws --endpoint-url=http://localhost:4566/ --profile localstack "$@"
  fi
}
