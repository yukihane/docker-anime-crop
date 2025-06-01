FROM nvcr.io/nvidia/pytorch:25.05-py3

WORKDIR /tmp

RUN apt update && apt install -y \
    libopencv-dev \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# CUDA環境変数を設定
ENV PATH="/usr/local/cuda-12.1/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/cuda-12.1/lib64"

COPY ./install /install

WORKDIR /app

# https://note.com/ai_meg/n/n7e02b5ac878c
RUN git clone https://github.com/yukihane/anime-crop.git -b fix-requirements

WORKDIR /app/anime-crop
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt --extra-index-url https://download.pytorch.org/whl/cu121
RUN sh /install/01additional_pip_install.sh
RUN cd / && patch -p1 < /install/02basicsr.patch
RUN sh /install/03download_weights.sh

CMD ["python", "anime_face_seg.py"]
# CMD ["/bin/bash"]
