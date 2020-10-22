#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

_INFO=$(printf "\e[1;32m>>\e[m")
_TASK=$(printf "\e[1;34m::\e[m")
_WARN=$(printf "\e[1;33m!!\e[m")
_ERROR=$(printf "\e[1;31m!!\e[m")

WORK_DIR=`pwd | xargs -0 dirname`
SOURCE_DIR="$WORK_DIR/home"

_usage() {
cat <<EOD
Migrate Usage:
-f | --from-fish: create ~/.zsh_history from ~/.local/share/fish/fish_history
EOD
}

# Search - Find dotfiles & config
_search() {
    find "$SOURCE_DIR" -mindepth 1 -maxdepth 1 \
        -name '.*' \
        -and -not -name '.DS_Store' \
        -and -not -name '.git' \
        -and -not -name '.gitmodules' \
        -and -not -name '.gitignore' \
        -and -not -name '.config' \
        | sed -e 's/\.\///g' \
        | sed -e 's/ /[SPACE]/g'


    find "$SOURCE_DIR/.config" -mindepth 1 -maxdepth 1 \
        | sed -e 's/\.\///g' \
        | sed -e 's/ /[SPACE]/g'
}

# List - List of dotfiles
_list() {
    for f in $(_search); do
        f_=${f//\[SPACE\]/ }
        echo "${f//\[SPACE\]/ } ($HOME${f_#$SOURCE_DIR})"
    done
}

# Check - Check requirements
_check() {
    echo "$_TASK Checking requirements..."
    REQUIRED=("curl" "git")
    OPTIONAL=("tmux" "zsh" "vim")

    for v in ${REQUIRED[@]}; do
        if [ "$(which "$v" &> /dev/null; echo $?)" == 0 ]; then
            echo "$_INFO Passed: $v"
        else
            echo "$_ERROR Could not find requirements: $v"
            exit 1
        fi
    done
    for v in ${OPTIONAL[@]}; do
        if [ "$(which "$v" &> /dev/null; echo $?)" == 0 ]; then
            echo "$_INFO Passed: $v"
        else
            echo "$_WARN Could not find optional: $v"
        fi
    done

    echo "$_TASK All check passed"
}

# Install - Install dotfiles
_install() {
    echo "$_TASK Extracting..."
    mkdir -p "$HOME/.config"
    for f in $(_search); do
        f_=${f//\[SPACE\]/ }
        ln -snfv "$f_" "$HOME${f_#$SOURCE_DIR}"
    done
    bash "$WORK_DIR/setup/install.sh"
}

# Clean - Remove dotfiles
_clean() {
    set +e
    echo "$_TASK Removing dotfiles..."
    for f in $(_search); do
        f_=${f//\[SPACE\]/ }
        rm -rfv "$HOME${f_#$SOURCE_DIR}"
    done

    echo "$_TASK Removing fzf"
    rm -rf "$HOME/.fzf"

    echo "$_TASK Removing Antigen"
    rm -rf "$HOME/.antigen"

    echo "$_TASK Removing vim bundles..."
    rm -rf "$HOME/.vim/bundle"
    rm -rf "$HOME/.vim/plugged"
}

_migrate_from_fish() {
    echo "migrate from fish"
    if ! command -v python3 &> /dev/null
    then
        echo "You need Python3 runtime to execute this command. Install from https://www.python.org/."
        exit 1
    fi
    python3 migrate.py
}


if [ "$1" = "list" ]; then
    _list
elif [ "$1" = "check" ]; then
    _check
elif [ "$1" = "install" ]; then
    _check
    _install
elif [ "$1" = "clean" ]; then
    _clean
elif [ "$1" = "migrate" ]; then
    shift
    while [ $# -gt 0 ] ; do
        case $1 in
            -f | --from-fish)
                echo "from fish!"; _migrate_from_fish
                exit 0
                ;;
            -h | --help)
                _usage
                exit 0
                ;;
            *)
                _usage
                exit 1
                ;;
        esac
    done
else
    echo "Usage: <list|check|install|clean>"
fi
