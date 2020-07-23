# Tsutomu-Ikeda/settings
設定ファイル一覧です。

## zshの使用方法
以下のセットアップ方法は [Laica-Lunasys/dotfiles](https://github.com/Laica-Lunasys/dotfiles) を参考にして作りました。[@Laica-Lunasys](https://github.com/Laica-Lunasys) さんありがとうございます。

### お試しで使う
既存環境を汚したくない場合におすすめの方法です。[Docker Hubにビルドされたイメージ](https://hub.docker.com/r/tomtsutom/zsh-sample) が上がっています。以下のコマンドを打つことで動作を確かめることができます。<br>
なお、dockerの環境構築が済んでいない方は [dockerのインストール](https://www.docker.com/get-started) から行ってください。

```bash
docker run --rm --name tomtsutom-zsh -e TZ=Asia/Tokyo -v $PWD:/home/host-machine -it tomtsutom/zsh-sample
```

### インストールする

```bash
git clone https://github.com/Tsutomu-Ikeda/settings
cd settings/unix/setup
make install
```
