# Docker for anime-crop

## 説明

- [レガシー AI シリーズ（２）　簡単アニメキャラ抜き出しアプリ｜めぐチャンネル](https://note.com/ai_meg/n/n7e02b5ac878c)

で解説されている [anime-crop](https://github.com/animede/anime-crop) を簡単に実行できるように Docker イメージ化するスクリプトです。

WSL2で動作確認しています。

## 使用方法

### ビルド

```sh
docker compose build
```

そこそこ時間がかかります。
私の環境では15分程度かかりました。

### 起動

```sh
docker compose up -d
```

でコンテナーを起動し、起動処理が完了するまで少し待った後、ブラウザーで次のURLにアクセスします:

- http://localhost:7860

### 終了

```sh
docker compose down
```
