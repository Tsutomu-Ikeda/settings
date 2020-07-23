# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#--------------------------
# zsh Configuration
#--------------------------
## Autoload
autoload -U colors; colors
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

#---------------------
# Import settings
#---------------------
# Init Antigen
source $HOME/.zsh/antigen.zsh

OS="$($HOME/.misc/get-osdist.sh | sed -n 1P)"
PROFILE_DIR="$HOME/.zsh/profile/$OS.zsh"
if [ -e $PROFILE_DIR ]; then
    source $PROFILE_DIR
fi

if [ -e $HOME/.zsh_profile ]; then
    source $HOME/.zsh_profile
fi

# PATH
if [ -e $HOME/bin ]; then
    export PATH=$HOME/bin:$PATH
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $HOME/.zsh/color.zsh
source $HOME/.zsh/alias.zsh
source $HOME/.zsh/util.zsh

#source $HOME/.zsh/vcs.zsh
#source $HOME/.zsh/prompt.zsh

#-----------------------
# Misc Settings
#-----------------------
# History
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# Disable Auto Title (for tmux)
DISABLE_AUTO_TITLE=false

#----------------------
# Bind Key
#----------------------
bindkey -e
bindkey "^?"    backward-delete-char
bindkey "^U"    backward-kill-line

bindkey '^[[Z' reverse-menu-complete

bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^[[L' forward-word

#----------------
# Completion
#----------------
# Option
setopt auto_param_slash
setopt mark_dirs
setopt list_types
setopt auto_menu
setopt auto_param_keys
setopt interactive_comments
setopt magic_equal_subst
setopt print_eight_bit
setopt hist_reduce_blanks

setopt complete_in_word
setopt always_last_prompt

setopt nonomatch

zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z} m:=_ m:=- m:=.'
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:options' description 'yes'

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache false

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

source $HOME/.zsh/greeting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#export POWERLEVEL9K_ALWAYS_SHOW_CONTEXT=true
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh && source $HOME/.zsh/p10k.zsh
