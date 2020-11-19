export BASH_SILENCE_DEPRECATION_WARNING=1

# prompt settings
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

PS1="$PS1"'\[\033[37m\]'       # change color(white)
PS1="$PS1"'\n'                 # new line
PS1="$PS1"'\$ '                # prompt: # or $

# setting for ls
if [ "$(uname)" = 'Darwin' ]; then
    export LSCOLORS=xbfxcxdxbxegedabagacad
    alias ls='ls -G'
else
    eval `dircolors ~/.colorrc`
    alias ls='ls --color=auto -h'
fi

alias grep='grep --binary-files=without-match --color=auto'
alias la='ls -lha'
alias ll='ls -lha'
alias shpwd='dirname $(cd $(dirname $0); pwd)'
