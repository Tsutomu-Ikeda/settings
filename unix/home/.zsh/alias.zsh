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

function git {
  if command -v check-ssh-agent-key 1>/dev/null 2>&1; then
    check-ssh-agent-key
  fi

  if [[ "$1" == "push" ]]; then
    if [[ "$@" == "push" ]]; then
      base="develop"
      if command git rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1; then
        base="@{u}"
      fi

      if command git log --oneline "$base..HEAD" | grep -q -i "don't push"; then
        echo "Found 'don't push' in commit messages. Aborting push."
        command git log --oneline "$base..HEAD" | grep -i "don't push"
        return 1
      fi

      command git push
    elif [[ "$2" == "-f" ]] || [[ "$2" = "--force" ]]; then
      command git push --force-with-lease --force-if-includes
    elif [[ "$@" == "push -u origin HEAD" ]]; then
      command git push -u origin HEAD
    else
      echo "invalid push option, nothing to do."
      return 1
    fi
  elif [[ "$1" == "switch" ]]; then
    if [[ "$2" == "-c" ]] && [[ -z "$4" ]]; then
      echo "please specify base branch"
      return 1
    elif [[ "$4" == origin/* ]]; then
      echo "do not specify remote branch for base branch"
      return 1
    else
      command git "$@"
    fi
  else
    command git "$@"
  fi
}
