# prompt settings
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash
HOST='\u@\h'
PS1="\[\033]0;$HOST\007\]"     # set window title
PS1="$PS1"'\n'                 # new line
PS1="$PS1"'\[\033[36m\]'       # change color(blue)
PS1="$PS1"'\u'
PS1="$PS1"'\[\033[32m\]'       # change color(green)
PS1="$PS1"'@\h '               # user@host<space>
PS1="$PS1"'\[\033[35m\]'       # change color(magenta)
PS1="$PS1"'bash:\v '            # bash<version><space>
PS1="$PS1"'\[\033[33m\]'       # change color(yellow)
PS1="$PS1"'\w'                 # current working directory
if test -z "$WINELOADERNOEXEC"
then
    PS1="$PS1"'\[\033[36m\]'   # change color(blue)
    PS1="$PS1"'$(__git_ps1)'   # bash function
fi
PS1="$PS1"'\[\033[37m\]'       # change color(white)
PS1="$PS1"'\n'                 # new line
PS1="$PS1"'\$ '                # prompt: # or $

# setting for grep
export GREP_OPTIONS="--binary-files=without-match --color=auto"

# setting for ls
if [ "$(uname)" = 'Darwin' ]; then
    export LSCOLORS=xbfxcxdxbxegedabagacad
    alias ls='ls -G'
else
    eval `dircolors ~/.colorrc`
    alias ls='ls --color=auto -h'
fi

alias la='ls -lha'
alias ll='ls -lha'
alias shpwd='dirname $(cd $(dirname $0); pwd)'

