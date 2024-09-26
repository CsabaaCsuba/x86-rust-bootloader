FROM randomdude/gcc-cross-x86_64-elf
FROM blacktop/vbox

RUN apt-get update 
RUN apt-get upgrade -y
RUN apt-get install -y nasm
RUN apt-get install -y xorriso
RUN apt-get install -y grub-pc-bin
RUN apt-get install -y grub-common
RUN apt-get install -y Virtual


VOLUME /root/env
WORKDIR /root/env