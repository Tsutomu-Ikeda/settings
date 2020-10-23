# 開発環境構築手順

## Mac
以下のコマンドはすべて `Terminal.app` を起動して実行します。

- Command Line Tools for XCode のインストール
  ```bash
  xcode-select --install
  ```
- [Homebrew](https://brew.sh/)のインストール
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  ```
- Git/GitHubの設定
  - [GitHubへ公開鍵を設定](https://github.com/settings/keys)
    ```bash
    ssh-keygen
    cat ~/.ssh/id_rsa.pub | pbcopy
    ```
  - Gitのコミット情報の設定
    ```bash
    git config --global user.name "tomtsutom"
    git config --global user.email "tomtsutom0122@gmail.com"
    ```
- 必要なアプリケーションのインストール
  - 以下の項目を一括でインストールする場合
    ```bash
    git clone git@github.com:Tsutomu-Ikeda/settings
    cd settings/unix/homebrew
    brew bundle
    ```
  - iTerm2のインストール
    ```bash
    brew cask install iterm2
    ```
  - Visual Studio Codeのインストール
    ```bash
    brew cask install visual-studio-code
    ```
  - Dockerのインストール
    ```bash
    brew cask install docker
    ```
  - キーバインドの変更
    ```bash
    brew cask install karabiner-elements
    ```
- シェル設定などの読み込み
  ```bash
  # git clone git@github.com:Tsutomu-Ikeda/settings
  cd settings/unix/setup
  make install
  ```

## Windows
- WSL(Ubuntu)のセットアップ
  - Git/GitHubの設定
    - [GitHubへ公開鍵を設定](https://github.com/settings/keys)
      ```bash
      ssh-keygen
      cat ~/.ssh/id_rsa.pub | clip.exe
      ```
    - Gitのコミット情報の設定
      ```bash
      git config --global user.name "tomtsutom"
      git config --global user.email "tomtsutom0122@gmail.com"
      ```
- Windows Terminalのインストール
  - https://www.microsoft.com/ja-jp/p/windows-terminal/9n0dx20hk701
- Visual Studio Codeのインストール
  - https://code.visualstudio.com/
- Dockerのインストール
  - https://www.docker.com/get-started
- キーバインドの変更
  - Change keyで <kbd>CapsLock</kbd> を <kbd>F24</kbd> (スキャンコード: `0x0076`) に割り当てる
  - Auto Hot Key (`windows/tomtsutom.ahk`) をスタートアップ (`C:\Users\ユーザー名\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`) に登録する
- シェル設定などの読み込み
  ```bash
  sudo apt-get install zsh
  chsh -s $(which zsh)
  git clone git@github.com:Tsutomu-Ikeda/settings
  cd settings/unix/setup
  make install
  ```
