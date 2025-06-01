# Docker environment for anime-crop

## 説明

- [レガシー AI シリーズ（２）　簡単アニメキャラ抜き出しアプリ｜めぐチャンネル](https://note.com/ai_meg/n/n7e02b5ac878c)

で解説されている [anime-crop](https://github.com/animede/anime-crop) を簡単に実行できるように Docker イメージ化するスクリプトです。

WSL2で動作確認しています。

## 使用方法

### ビルド(GPUを使用しない)

冒頭リンク先の説明通りGPUを利用せずCPUのみで動作させる場合、こちらの手順でビルドします。
GPUを利用する場合は本節をスキップし、次の節を参照してください。

`feature/cpu` ブランチをチェックアウトし、ビルドします:

```sh
git clone https://github.com/yukihane/docker-anime-crop.git -b feature/cpu
cd docker-anime-crop
docker compose build
```

そこそこ時間がかかります。
私の環境では20分程度かかりました。

### ビルド(GPUを利用する)

WIP

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
