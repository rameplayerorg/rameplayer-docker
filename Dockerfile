FROM alpine:3.3

MAINTAINER Tuomas Jaakola <tuomas.jaakola@iki.fi>

LABEL description="Development environment for RamePlayer"

ENV RAME_DIR /opt/rame

RUN apk --update add \
    dbus \
    eudev \
    ffmpeg \
    git \
    lua5.3 \
    lua5.3-cjson \
    lua5.3-penlight \
    lua5.3-posix \
    lua5.3-cqueues \
    lua5.3-ldbus \
    lua5.3-socket \
    nodejs \
    openssh \
    supervisor

# Set root password to 'rpi'
RUN echo root:rpi | chpasswd

COPY sshd_config /etc/ssh/
COPY supervisord.conf /etc/

# Generate new host keys
RUN ssh-keygen -A

RUN mkdir -p ${RAME_DIR} && \
    cd ${RAME_DIR} && \
    git clone https://github.com/fabled/lua-cqueues-pushy.git && \
    git clone https://github.com/rameplayerorg/rameplayer-backend.git && \
    git clone https://github.com/rameplayerorg/rameplayer-webui.git && \
    cd rameplayer-backend && \
    ln -s ../lua-cqueues-pushy/cqp .

# Build webui
RUN cd ${RAME_DIR}/rameplayer-webui && \
    npm install -g bower gulp && \
    bower --allow-root install && \
    npm install && \
    gulp build

VOLUME ["/opt/rame"]

EXPOSE 22 80 8000

# Use supervisord to launch httpd and rameplayer-backend
CMD ["/usr/bin/supervisord"]
