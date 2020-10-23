alias ls='ls --color'
alias ll='ls -lh --color'
alias la='ls -lah --color'

WINDOWS_HOME=$(echo $PATH | tr ':' '\n' | grep -oE "/mnt/c/Users/[A-Za-z ]+/" -m 1)

cdpath=($WINDOWS_HOME $WINDOWS_HOME/Documents $WINDOWS_HOME/Documents/cl2 $WINDOWS_HOME/Development $cdpath)
