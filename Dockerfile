FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN set -ex; \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        dbus-x11 \
        pcmanfm \
        leafpad \
        lxterminal \
        xvkbd \
	tmux \
        nano \
	bash \
        net-tools \
        novnc \
        socat \
        x11vnc \
	xvfb \
        icewm \
        supervisor \
        curl \
        git \
        wget \
        chromium-browser \
        ssh \
        locales \
    && 	echo "root:demo1234" | chpasswd \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*
RUN dpkg-reconfigure locales
RUN \
    /bin/bash -c "echo -e 'abcd1234\nabcd1234\ny\nn' | x11vnc -storepasswd"; echo; \
    chmod +x ~/.vnc/passwd; 
COPY . /app
RUN chmod +x /app/conf.d/websockify.sh
RUN chmod +x /app/run.sh
RUN echo icewm-session >~/.xsession

CMD ["/app/run.sh"]
