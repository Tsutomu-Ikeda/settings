alias ls='ls --color'
alias ll='ls -lh --color'
alias la='ls -lah --color'

SSH_AGENT_FILE=$HOME/.ssh-agent
test -f $SSH_AGENT_FILE && source $SSH_AGENT_FILE

function check-ssh-agent-key() {
  if ! ssh-add -l > /dev/null 2>&1; then
    ssh-agent > $SSH_AGENT_FILE
    source $SSH_AGENT_FILE
    ssh-add -t 86400 $HOME/.ssh/id_rsa
  fi
}

function ssh() {
  check-ssh-agent-key

  command ssh "$@"
}
