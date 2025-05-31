FROM python:3.11.12-bookworm

WORKDIR /app

COPY ./install /install

# https://note.com/ai_meg/n/n7e02b5ac878c
RUN git clone  https://github.com/animede/anime-crop.git

WORKDIR /app/anime-crop
RUN pip install --upgrade pip && pip install -r requirements.txt --extra-index-url https://download.pytorch.org/whl/cu121
RUN sh /install/01additional_pip_install.sh
RUN patch -p0 < /install/02patch_basicSR.patch
RUN sh /install/03download_weights.sh

CMD ["/bin/bash"]
