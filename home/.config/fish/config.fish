if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end
set -U FZF_LEGACY_KEYBINDINGS 0

set -x PATH $HOME/.pyenv/bin $PATH
. (pyenv init - | psub)

set -x LSCOLORS xbfxcxdxbxegedabagacad

set -x PGDATA /usr/local/var/postgresql@9.6
set -g fish_user_paths "/usr/local/opt/postgresql@9.6/bin" $fish_user_paths

set -g PATH "$HOME/.rbenv/bin:$PATH"
. (rbenv init - | psub)

set -x MPLBACKEND "module://itermplot"
