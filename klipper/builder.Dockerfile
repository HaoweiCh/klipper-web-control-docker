FROM python:3.10-bullseye

ARG DEBIAN_FRONTEND=noninteractive
ARG KLIPPER_BRANCH="master"

ARG USER=klippy
ARG HOME=/home/${USER}
ARG KLIPPER_VENV_DIR=${HOME}/klippy-env

RUN useradd -d ${HOME} -ms /bin/bash ${USER}
RUN apt-get update && \
    apt-get install -y locales git sudo wget curl gzip tar python2

RUN apt-get update && \
    apt-get install -y virtualenv python-dev libffi-dev build-essential libncurses-dev libusb-dev gpiod python3-virtualenv python3-dev libopenjp2-7 python3-libgpiod liblmdb-dev libsodium-dev

RUN sed -i -e 's/# en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen
RUN locale-gen

ENV LC_ALL en_GB.UTF-8 
ENV LANG en_GB.UTF-8  
ENV LANGUAGE en_GB:en   

# USER ${USER}
USER ROOT
WORKDIR ${HOME}

### Klipper setup ###
RUN git clone --single-branch --branch ${KLIPPER_BRANCH} https://github.com/Klipper3d/klipper.git klipper
RUN [ ! -d ${KLIPPER_VENV_DIR} ] && virtualenv -p python2 ${KLIPPER_VENV_DIR}
RUN ${KLIPPER_VENV_DIR}/bin/python -m pip install pip -U
RUN ${KLIPPER_VENV_DIR}/bin/pip install wheel
RUN ${KLIPPER_VENV_DIR}/bin/pip install -r klipper/scripts/klippy-requirements.txt

WORKDIR ${HOME}/klipper

CMD ["bash"]