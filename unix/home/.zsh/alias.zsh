alias rebirth='echo Reincarnate zsh... ; rm -rfv ~/.antigen/ ; [ ! -d ~/.antigen ] && mkdir -p ~/.antigen && curl -L git.io/antigen > ~/.antigen/antigen.zsh; source ~/.zshrc'
alias nconsole='tmux new-s -s Console'
alias restart=". ~/.zshrc"
alias docker-compose-dev='docker-compose -f docker-compose.dev.yml'
alias tree="tree -N"
alias less="less -R"
alias codei='code-insiders'

function cd {
  builtin cd "$@"
  if [[ $OLDPWD != $PWD ]]
  then
    BACK_HISTORY=$OLDPWD:$BACK_HISTORY
    FORWARD_HISTORY=""
  fi
}

function .. {
  cd ..
}

function bd {
  DIR=${BACK_HISTORY%%:*}
  if [[ -d "$DIR" ]]
  then
    BACK_HISTORY=${BACK_HISTORY#*:}
    FORWARD_HISTORY=$PWD:$FORWARD_HISTORY
    builtin cd "$DIR"
  else
    echo "empty \$BACK_HISTORY"
  fi
}

function fd {
  DIR=${FORWARD_HISTORY%%:*}
  if [[ -d "$DIR" ]]
  then
    FORWARD_HISTORY=${FORWARD_HISTORY#*:}
    BACK_HISTORY=$PWD:$BACK_HISTORY
    builtin cd "$DIR"
  else
    echo "empty \$FORWARD_HISTORY"
  fi
}
