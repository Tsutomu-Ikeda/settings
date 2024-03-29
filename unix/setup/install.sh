#!/usr/bin/env bash

cd "$(dirname "$0")"
set -e

_INFO=$(printf "\e[1;32m>>\e[m")
_TASK=$(printf "\e[1;34m::\e[m")
_WARN=$(printf "\e[1;33m!!\e[m")
_ERROR=$(printf "\e[1;31m!!\e[m")

echo "$_TASK Setup fzf..."
if [[ ! -d ~/.fzf.zsh ]]; then
    if command -v brew 1>/dev/null 2>&1; then
        brew install fzf
        $(brew --prefix)/opt/fzf/install --all --no-bash --no-fish
        perl -i -p -e "s/fc -rl 1/fc -rli 1/g" $(brew --prefix)/opt/fzf/shell/key-bindings.zsh
    else
        git clone https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all --no-bash --no-fish
        perl -i -p -e "s/fc -rl 1/fc -rli 1/g" ~/.fzf/shell/key-bindings.zsh
    fi
fi

echo "$_TASK Setup Antigen..."
if [ ! -d ~/.antigen ]; then
    mkdir -p ~/.antigen
    curl -L git.io/antigen > ~/.antigen/antigen.zsh
    if [ $(which zsh) ]; then
        zsh -c "source ~/.zshrc && exit 0"
    fi
fi

echo "$_TASK Setup tpm..."
if [ ! -d ~/.tmux/plugins/tpm ]; then
    mkdir -p ~/.tmux/plugins/tpm
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "$_TASK Setup vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "$_TASK Executing: 'vim -c :PlugInstall'"
vim -c ':PlugInstall' -c ':q' -c ':q'
echo "$_TASK Installed vim packages"

echo "$_INFO Operation success! starting zsh..."
exec zsh
