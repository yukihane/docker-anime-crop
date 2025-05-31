FROM python:3.13.3-bookworm

WORKDIR /app

# RUN apt update && apt install -y \
#     libopencv-dev \
#     && rm -rf /var/lib/apt/lists/*

COPY ./install /install

# https://note.com/ai_meg/n/n7e02b5ac878c
RUN git clone  https://github.com/animede/anime-crop.git

WORKDIR /app/anime-crop
RUN pip install --upgrade pip && pip install -r requirements.txt && sh /install/01additional_pip_install.sh
# RUN curl -L -o 'weights/ssd_best8.pth'  'https://huggingface.co/UZUKI/webapp1/resolve/main/ssd_best8.pth?download=true'

CMD ["/bin/bash"]
