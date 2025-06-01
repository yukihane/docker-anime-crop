FROM python:3.11.12-bookworm

WORKDIR /app

RUN apt update && apt install -y \
    libopencv-dev \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./install /install

# https://note.com/ai_meg/n/n7e02b5ac878c
RUN git clone  https://github.com/animede/anime-crop.git

WORKDIR /app/anime-crop
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt --extra-index-url https://download.pytorch.org/whl/cu121
RUN sh /install/01additional_pip_install.sh
RUN cd / && patch -p1 < /install/02basicsr.patch
RUN sh /install/03download_weights.sh

RUN git remote add yukihane https://github.com/yukihane/anime-crop.git \
    && git fetch yukihane \
    && git checkout yukihane/feature/without-upscale

CMD ["python", "anime_face_seg.py"]
