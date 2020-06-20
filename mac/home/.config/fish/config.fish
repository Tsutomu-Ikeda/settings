if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end
set -U FZF_LEGACY_KEYBINDINGS 0

set -x LSCOLORS xbfxcxdxbxegedabagacad

# zlibのための設定
set -gx LDFLAGS "-L/usr/local/opt/zlib/lib"
set -gx CPPFLAGS "-I/usr/local/opt/zlib/include"

set -x PATH $HOME/.pyenv/bin $PATH
source (pyenv init - | psub)
set -g PATH $HOME/.rbenv/bin $PATH
source (rbenv init - | psub)
set -g fish_user_paths "/usr/local/sbin" /usr/local/opt/mysql-client/bin $fish_user_paths
set -gx CDPATH $HOME/Development/cl2 $HOME/Development $HOME/Document $HOME .

function brew
  set tmp_PATH $PATH

  # for rbenv
  set -l i (contains -i $HOME/.rbenv/shims $PATH)
  set PATH[$i] "/bin" # /bin is dummy

  # for pyenv
  set -l i (contains -i $HOME/.pyenv/shims $PATH)
  set PATH[$i] "/bin" # /bin is dummy

  command brew $argv

  set PATH $tmp_PATH
end

alias mysql="mysql --host=127.0.0.1"
alias today='set TODAY_FILENAME (env LC_TIME="ja_JP.UTF-8" date "+%Y年%m月%d日 (%a)") && echo "## $TODAY_FILENAME" > "$TODAY_FILENAME.md"'
# rm をゴミ箱に移動する動作に変更
alias rm="rmtrash"

alias aws='aws --endpoint-url=$AWS_ENDPOINT'
set -x AWS_ENDPOINT "http://tom-nas:9000"
set -x AWS_PROFILE "minio"

function aws_sw
    if test "$AWS_PROFILE" = "minio"
        echo "AWS configure switched to default"
        set --erase AWS_ENDPOINT
        set --erase AWS_PROFILE
    else
        echo "AWS configure switched to minio"
        export AWS_ENDPOINT="http://tom-nas:9000"
        export AWS_PROFILE="minio"
    end
end

set -x MPLBACKEND "module://itermplot"
# 黒背景で良しなにプロットするためのオプション
set -x ITERMPLOT "rv"

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

function postexec_command --on-event fish_postexec
    echo
end

