# 開発環境構築手順

## Mac

- Command Line Tools for XCode のインストール
  ```bash
  xcode-select --install
  ```
- (M1 Macの場合) Rosetta2をインストールする
  ```bash

  softwareupdate --install-rosetta
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

    # エイリアスの設定
    git config --global alias.force-pull '!git stash && git pull --rebase && (git stash pop || :)'
    git config --global alias.copy-current-branch-name '!git branch --show-current | tr -d "\n" | pbcopy && pbpaste'
    git config --global alias.approve-pr '!bash -c '\''echo "$0" | gh pr review --approve --body-file -'\'' -'
    git config --global alias.approve-pr-with-cat '!bash -c '\''echo "$1<br> [![LGTMeow]("'\''$(shuf -n1 ~/.config/git/lgtmeow.txt)'\''")](https://lgtmeow.com)" | gh pr review --approve --body-file -'\'' -'
    git config --global alias.delete-merged-branches '!git branch --merged | egrep -v '\''\*|(^ *(develop|main|master)$)|\+'\'' | xargs git branch -d'
    git config --global alias.delete-remote-deleted-branches '!git fetch --prune 2>&1 | tee | egrep "^ .+deleted" | perl -pe "s: - .deleted. *.none. *-> origin/::g" | (xargs git branch -D  2>&1 || :) | perl -pe "s/^error: (branch .+ not found)\.?$/warning: \1/g" | zsh -c "tee >(cat) | perl -nle '\''exit 1 if m/^error:/'\''"'
    git config --global alias.parent '!git show-branch | grep "*[^[]\+\[" | grep -v "$(git rev-parse --abbrev-ref HEAD)" | awk -F'\''[]~^[]'\'' "{print \$2}" | sort | uniq | awk '\''BEGIN {} {for(i=0;i<NF;i++) { branch=$i; if(branch ~ /^develop$/) { d=d""branch"\n" } else if (branch ~ /^epic\//) { e=e""branch"\n" } else { o=o""branch"\n" } } } END {printf d""e""o}'\'' | head -n1'

    git config --global init.defaultBranch main

    # 自動的に上流ブランチをセットしてくれるオプション
    # 新しいブランチを作成するたびに `git push --set-upstream origin HEAD` する必要がなくなる
    git config --global --add --bool push.autoSetupRemote true

    git config --global push.useForceIfIncludes yes
    ```
- 設定の反映
  ```bash
  cd ~
  git clone git@github.com:Tsutomu-Ikeda/settings
  cd settings/unix/setup
  brew install coreutils  # glsを入れるため
  make install
  ```
- [pyenv](https://github.com/pyenv/pyenv), [rbenv](https://github.com/rbenv/rbenv), [nodenv](https://github.com/nodenv/nodenv)のインストール
  ```bash
  brew install pyenv rbenv nodenv
  # 最新の安定版をインストールする
  pyenv install $(pyenv install --list | grep -E '^ *3\.\d+\.\d+$' | tail -n1) && pyenv global $(pyenv versions | grep -v '*' | tail -n1)
  rbenv install $(rbenv install --list | grep -E '^ *3\.\d+\.\d+$' | tail -n1) && rbenv global $(rbenv versions | grep -v '*' | tail -n1)
  nodenv install $(nodenv install --list | grep -E '^ *\d[02468]\.\d+\.\d+$' | tail -n1) && nodenv global $(nodenv versions | grep -v '*' | tail -n1)
  ```
- gitのエイリアス設定
  - git-browse-remoteのインストール
    ```bash
    gem install git-browse-remote
    git config --global alias.open browse-remote

    git open --init
    ```
- 必要なアプリケーションのインストール
  - 以下の項目を一括でインストールする場合
    ```bash
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
  - MeetingBarのインストール
    ```bash
    brew install --cask meetingbar
    ```
  - 1Passwordのインストール
    ```bash
    brew install --cask 1password
    ```
  - Alfredのインストール
    ```bash
    brew install --cask alfred
    ```
    SpotLight無効化
  - Zoomのインストール
    ```bash
    brew install --cask zoom
    ```
    - 一般
      - 「ZoomをmacOSメニューバーに追加」チェックを外す☑️
    - オーディオ
      - 「ミーティングへの接続時に、自動的にコンピュータオーディオに接続」チェックをつける ✅
      - 「ミーティングの参加時にマイクをミュートに設定」チェックをつける✅
    - 画面の共有
      - 「画面を共有している場合のウィンドウサイズ」 現在のサイズを保持する
    - 権限の設定画面共有
      - ホーム画面から「画面の共有」を押して設定を開く
  - Karabiner Elementsのインストール
    ```bash
    brew install karabiner-elements
    ```
    Catalina 以降の MacOSではKarabiner Elementsに `Full Disk Access` を与える必要があります。
  - Tunnelblick
    ```bash
    brew install --cask tunnelblick
    ```
  - RunCat
    ```bash
    mas install 1429033973
    ```
  - BetterSnapTool
    ```bash
    mas install 417375580
    ```
  - Fuwari
    ```bash
    mas install 1187652334
    ```
  - MonitorControl
    ```bash
    brew install --cask monitorcontrol
    ```
    ![](../assets/images/provisioning/monitor_control_general.png)
    ![](../assets/images/provisioning/monitor_control_app_menu.png)
    ![](../assets/images/provisioning/monitor_control_keyboard.png)
- Ricty Diminishedの設定
  - バックスラッシュがうまく表示されない問題
    - https://qiita.com/uKLEina/items/ff0877871fc425952b92#comment-74375ba083e256f6c787
    ```bash
    # brew install fontforge
    cat <<EOFF > modify_ricty_script
    #!/usr/bin/env fontforge

    Open(\$1)
    Select(0u0060)
    SetGlyphClass("base")
    Generate(\$1)
    EOFF

    chmod a+x modify_ricty_script

    find ~/Library/Fonts/RictyDiminished*.ttf | xargs -I {} fontforge -lang ff -script modify_ricty_script {}
    rm modify_ricty_script
    ```
  - なぜRicty Diminishedを使うか
    - 全角スペースと半角スペースの区別がつく

### デフォルトのブラウザの設定

```bash
open -a "Google Chrome" --args --make-default-browser
```

### テーマをダークテーマにする

```
sudo defaults write /Library/Preferences/.GlobalPreferences AppleInterfaceTheme Dark
killall Dock
killall SystemUIServer
```

### 指紋認証の設定

自動化できなさそう

### AppleIDの設定

- `AppleID > iCloud > iCloud Drive (Options) > Desktop & Documents Folders` のチェックを外す

```
defaults write com.apple.finder FXICloudDriveDesktop -bool false
defaults write com.apple.finder FXICloudDriveDocuments -bool false
defaults write com.apple.finder FXICloudDriveEnabled -bool false
```

### トラックパッドの設定

- ポインターの速度を一番速くする
- タップしてクリップを有効にする
- 調べる＆データ検出を無効にする

```
defaults write -g com.apple.trackpad.scaling -int 3
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write -g com.apple.mouse.tapBehavior -bool true
defaults write -g com.apple.trackpad.forceClick -bool false
```

### Dockの設定

- `Dock > Show recent applications in Dock` を無効化
- 初期設定でDockに設定されているアプリを消して、スッキリさせる
- 最新の使用状況に基づいて操作スペースを自動的に並び替えるを無効化

```
defaults write com.apple.dock show-recents -int 0
function __dock_item() {
 printf '%s%s%s%s%s' '<dict><key>tile-data</key><dict><key>file-data</key><dict>' '<key>_CFURLString</key><string>' "$1" '</string><key>_CFURLStringType</key><integer>0</integer>' '</dict></dict></dict>'
}
defaults write com.apple.dock persistent-apps -array "$(__dock_item /Applications/Google\ Chrome.app/)" \
"$(__dock_item /Applications/Slack.app/)" \
"$(__dock_item /Applications/Visual\ Studio\ Code.app/)" \
"$(__dock_item /Applications/iTerm.app/)" \
"$(__dock_item /System/Applications/System\ Preferences.app/)"
defaults write com.apple.dock mru-spaces -bool false
killall Dock
```

自動で隠す

```bash
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
killall Dock
```

### 音の設定

- `Sound > Play user interface sound effects` のチェックを外す

```
defaults write -g com.apple.sound.uiaudio.enabled -int 0
```

### キーボードの設定

- `Adjust keyboard brightness in low light` のチェックを外す
- `Use F1, F2, etc. keys as standard function keys` のチェックをつける
- `keyboard > Text > Add period with double space` のチェックを外す
- `keyboard > Text > Capitalize words automatically` のチェックを外す

```
sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Keyboard Enabled" -int 0
defaults write -g com.apple.keyboard.fnState -int 1
defaults write -g NSAutomaticPeriodSubstitutionEnabled -int 0
defaults write -g NSAutomaticCapitalizationEnabled -int 0
```

- `入力ソース > 日本語 - ローマ字入力 > 数字を全角入力` のチェックを外す

```
defaults write com.apple.inputmethod.Kotoeri JIMPrefFullWidthNumeralCharactersKey -float 0
killall -HUP JapaneseIM-RomajiTyping
```

### スクショの設定

```bash
defaults write com.apple.screencapture disable-shadow -boolean true  # ウィンドウを撮影したときの余白を削除
defaults write com.apple.screencapture type jpg  # JPEG形式にする
defaults write com.apple.screencapture target clipboard  # 保存先をクリップボードにする
killall SystemUIServer
```

### .DS_Storeを作らないようにする

```bash
defaults write com.apple.desktopservices DSDontWriteNetworkStores True
killall Finder
```

### 辞書を調べるショートカットキー「Control + Command + D」を無効にする

```bash
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 70 '<dict><key>enabled</key><false/></dict>'
```

参考: https://apple.stackexchange.com/questions/22785/how-do-i-disable-the-command-control-d-word-definition-keyboard-shortcut-in-os-x

コマンドを実行後再起動する

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
