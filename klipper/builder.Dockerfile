FROM dimalo/klipper-moonraker

WORKDIR /home/klippy/klipper

USER root

RUN apt-get update
RUN apt-get install -y locales git sudo wget curl gzip tar python2 && \
  virtualenv python-dev libffi-dev build-essential libncurses-dev libusb-dev && \
  gpiod python3-virtualenv python3-dev libopenjp2-7 python3-libgpiod liblmdb-dev && \
  libsodium-dev gcc-arm-none-eabi

CMD ["bash"]