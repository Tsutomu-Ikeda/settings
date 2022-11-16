alias rebirth='echo Reincarnate zsh... ; rm -rfv ~/.antigen/ ; [ ! -d ~/.antigen ] && mkdir -p ~/.antigen && curl -L git.io/antigen > ~/.antigen/antigen.zsh; source ~/.zshrc'
alias nconsole='tmux new-s -s Console'
alias restart=". ~/.zshrc"
alias docker-compose-dev='docker-compose -f docker-compose.dev.yml'
alias tree="tree -N"
alias less="less -R"

function esed {
  local -A opthash
  zparseopts -D -A opthash -- i

  if [[ -n "${opthash[(i)-i]}" ]]; then
    perl -i -pe "$@"
  else
    perl -pe "$@"
  fi
}

function cd {
  builtin cd "$@"
  if [[ $OLDPWD != $PWD ]]; then
    BACK_HISTORY=$OLDPWD:$BACK_HISTORY
    FORWARD_HISTORY=""
  fi

  if [[ -f ./utils.zsh ]]; then
    source ./utils.zsh
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
    echo "bd: ${#BACK_HISTORY//[^:]}, fd: ${#FORWARD_HISTORY//[^:]}"
  else
    echo "empty \$BACK_HISTORY"
    return 1
  fi
}

function fd {
  DIR=${FORWARD_HISTORY%%:*}
  if [[ -d "$DIR" ]]
  then
    FORWARD_HISTORY=${FORWARD_HISTORY#*:}
    BACK_HISTORY=$PWD:$BACK_HISTORY
    builtin cd "$DIR"
    echo "bd: ${#BACK_HISTORY//[^:]}, fd: ${#FORWARD_HISTORY//[^:]}"
  else
    echo "empty \$FORWARD_HISTORY"
    return 1
  fi
}

function mp4nize {
  local target_file="$(ls ~/Desktop/*.mov | sort | head -n1)"
  ffmpeg -i "$target_file" -an "$1" && rm "$target_file"
}
