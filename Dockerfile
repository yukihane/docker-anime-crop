# FROM python:3.11.12-bookworm
FROM nvcr.io/nvidia/pytorch:25.05-py3

WORKDIR /tmp

# NVIDIAのaptリポジトリをセットアップ
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-keyring_1.0-1_all.deb \
    && dpkg -i cuda-keyring_1.0-1_all.deb \
    && apt update

RUN apt install -y \
    libopencv-dev \
    cuda \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# cuDNN
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/libcudnn9-cuda-12_9.10.1.4-1_amd64.deb && \
    wget https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/libcudnn9-headers-cuda-12_9.10.1.4-1_amd64.deb && \
    wget https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/libcudnn9-dev-cuda-12_9.10.1.4-1_amd64.deb && \
    dpkg -i libcudnn9-cuda-12_9.10.1.4-1_amd64.deb && \
    dpkg -i libcudnn9-headers-cuda-12_9.10.1.4-1_amd64.deb && \
    dpkg -i libcudnn9-dev-cuda-12_9.10.1.4-1_amd64.deb && \
    rm libcudnn9-cuda-12_9.10.1.4-1_amd64.deb libcudnn9-headers-cuda-12_9.10.1.4-1_amd64.deb libcudnn9-dev-cuda-12_9.10.1.4-1_amd64.deb \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# CUDA環境変数を設定
ENV PATH="/usr/local/cuda-12.1/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/cuda-12.1/lib64"

COPY ./install /install

WORKDIR /app

# https://note.com/ai_meg/n/n7e02b5ac878c
RUN git clone  https://github.com/animede/anime-crop.git

WORKDIR /app/anime-crop
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt --extra-index-url https://download.pytorch.org/whl/cu121
RUN sh /install/01additional_pip_install.sh
RUN cd / && patch -p1 < /install/02basicsr.patch
RUN sh /install/03download_weights.sh

# CMD ["python", "anime_face_seg.py"]
CMD ["/bin/bash"]
