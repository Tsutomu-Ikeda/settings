# 開発環境構築手順

## Mac

### AppleIDの設定
- `AppleID > iCloud > iCloud Drive (Options) > Desktop & Documents Folders` のチェックを外す

### トラックパッドの設定
- ポインターの速度を一番速くする
- タップしてクリップを有効にする

### Dockの設定
- `Dock > Show recent applications in Dock` を無効化

### 音の設定
- `Sound > Play user interface sound effects` のチェックを外す

### キーボードの設定
- `Adjust keyboard brightness in low light` のチェックを外す
- `Use F1, F2, etc. keys as standard function keys` のチェックをつける
- `keyboard > Text > Add period with double space` のチェックを外す

以下のコマンドはすべて `Terminal.app` を起動して実行します。

- Command Line Tools for XCode のインストール
  ```bash
  xcode-select --install
  ```
- [Homebrew](https://brew.sh/)のインストール
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  ```
- SSH(Git/GitHub)の設定
  - [GitHubへ公開鍵を設定](https://github.com/settings/keys)
    ```bash
    ssh-keygen
    cat ~/.ssh/id_rsa.pub | pbcopy
    cat <<EOF >> ~/.ssh/config
    Host *
      UseKeyChain yes
      AddKeysToAgent yes
    EOF
    ```
  - Gitの設定
    ```bash
    git config --global pull.rebase false
    git config --global user.name "tomtsutom"
    git config --global user.email "40418321+Tsutomu-Ikeda@users.noreply.github.com"
    ```
- 必要なアプリケーションのインストール
  - 以下の項目を一括でインストールする場合
    ```bash
    git clone git@github.com:Tsutomu-Ikeda/settings
    cd settings/unix/homebrew
    brew bundle
    ```
  - Google Chromeインストール
    ```bash
    brew install google-chrome
    ```
  - iTerm2のインストール
    ```bash
    brew install iterm2
    ```
  - Visual Studio Codeのインストール
    ```bash
    brew install visual-studio-code
    ```
  - Dockerのインストール
    ```bash
    brew install --cask docker
    ```
  - キーバインドの変更
    ```bash
    brew install karabiner-elements
    ```
    Catalina 以降の MacOSではKarabiner Elementsに `Full Disk Access` を与える必要があります。
- pyenvでPythonインタプリタをインストールする
  ```bash
  export CFLAGS="-I$(brew --prefix zlib)/include -I$(brew --prefix openssl)/include -I$(brew --prefix bzip2)/include -I$(brew --prefix readline)/include -I$(xcrun --show-sdk-path)/usr/include"
  export LDFLAGS="-L$(brew --prefix zlib)/lib -L$(brew --prefix openssl)/lib -L$(brew --prefix bzip2)/lib -L$(brew --prefix readline)/lib"
  arch -arch x86_64 env PATH=${PATH/\/opt\/homebrew\/bin:/} pyenv install 3.8.7
  pyenv global 3.8.7
  ```
- シェル設定などの読み込み
  ```bash
  # git clone git@github.com:Tsutomu-Ikeda/settings
  cd settings/unix/setup
  brew install coreutils  # glsを入れるため
  make install
  ```
- Ricty Diminishedの設定
  - バックスラッシュがうまく表示されない問題
  - なぜRicty Diminishedを使うか
    - 全角スペースと半角スペースの区別がつく
- スクショの設定
  ```bash
  defaults write com.apple.screencapture disable-shadow -boolean true  # ウィンドウを撮影したときの余白を削除
  defaults write com.apple.screencapture type jpg  # JPEG形式にする
  defaults write com.apple.screencapture target clipboard  # 保存先をクリップボードにする
  killall SystemUIServer
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
      git config pull.rebase false
      git config --global user.name "tomtsutom"
      git config --global user.email "40418321+Tsutomu-Ikeda@users.noreply.github.com"
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
