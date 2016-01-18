FROM alpine:3.3

MAINTAINER Tuomas Jaakola <tuomas.jaakola@iki.fi>

LABEL description="Development environment for RamePlayer"

ENV RAME_DIR /opt/rame

RUN apk --update add lua5.3 lua5.3-cjson lua5.3-penlight lua5.3-posix \
    lua5.3-cqueues lua5.3-ldbus lua5.3-socket dbus eudev ffmpeg git \
    nodejs supervisor

COPY supervisord.conf /etc/supervisord.conf

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

EXPOSE 80 8000

# Use supervisord to launch httpd and rameplayer-backend
CMD ["/usr/bin/supervisord"]
