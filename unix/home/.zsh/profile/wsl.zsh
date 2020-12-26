alias ls='ls --color'
alias ll='ls -lh --color'
alias la='ls -lah --color'

WINDOWS_HOME=$(echo $PATH | tr ':' '\n' | grep -oE "/mnt/c/Users/[^/]+" -m 1)

cdpath=(
  $WINDOWS_HOME(N-/)
  $WINDOWS_HOME/Documents(N-/)
  $WINDOWS_HOME/Documents/cl2(N-/)
  $WINDOWS_HOME/Development(N-/)
  $cdpath
)
