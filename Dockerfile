FROM python:3.11.12-bookworm
# FROM nvcr.io/nvidia/pytorch:25.05-py3

WORKDIR /app

# NVIDIA CUDAリポジトリをセットアップ
RUN apt update && apt install -y \
    gnupg2 curl ca-certificates && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb -o cuda-keyring.deb && \
    dpkg -i cuda-keyring.deb && \
    rm cuda-keyring.deb && \
    apt update

# CUDA 12.1とCUDNN開発パッケージをインストール
RUN apt install -y \
    libopencv-dev \
    cuda-toolkit-12-1 \
    libcudnn8 \
    libcudnn8-dev \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# CUDA環境変数を設定
ENV PATH="/usr/local/cuda-12.1/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/cuda-12.1/lib64:${LD_LIBRARY_PATH}"

COPY ./install /install

# https://note.com/ai_meg/n/n7e02b5ac878c
RUN git clone  https://github.com/animede/anime-crop.git

WORKDIR /app/anime-crop
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt --extra-index-url https://download.pytorch.org/whl/cu121
RUN sh /install/01additional_pip_install.sh
RUN cd / && patch -p1 < /install/02basicsr.patch
RUN sh /install/03download_weights.sh

# CMD ["python", "anime_face_seg.py"]
CMD ["/bin/bash"]
