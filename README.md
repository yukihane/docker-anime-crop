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

「起動」節までスキップしてください。

### GPUを利用する場合の環境セットアップ

前節「ビルド(GPUを使用しない)」でビルドした環境だと実用的な時間で処理が終わらない(注)のでGPU(CUDA)を利用するようにセットアップします。

注: おそらくReal-ESRGANが重い; 逆に言うとアップスケールが発生しないなら実用的な範囲で収まると思われる

[WSL で NVIDIA CUDA を有効にする](https://learn.microsoft.com/ja-jp/windows/ai/directml/gpu-cuda-in-wsl) からたどれる資料を参考にして環境をセットアップします。

資料、とは具体的にはNVIDIAの公式資料[CUDA on WSL User Guide](https://docs.nvidia.com/cuda/wsl-user-guide/index.html)で、やるべきことをもう少し詳しく書くと:

- WindowsにNVIDIAドライバーをインストールする
- WSL2環境に[NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)をインストールする
- WSL2環境に[CUDA Toolkit](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=WSL-Ubuntu&target_version=2.0&target_type=deb_network)をインストールする

### ビルド(GPUを利用する)

`main` ブランチをチェックアウトし、ビルドします:

```sh
git clone https://github.com/yukihane/docker-anime-crop.git -b main
cd docker-anime-crop
docker compose build
```

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
