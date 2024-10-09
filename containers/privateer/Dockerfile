FROM parrotsec/security:latest

ENV DISPLAY :99
ENV XDG_CURRENT_DESKTOP XFCE

RUN apt update && \
    apt install -y curl && \
    apt install -y --no-install-recommends xvfb && \
    apt install -y --no-install-recommends xauth && \
    apt install -y libnss3-dev && \
    apt install -y libgbm-dev && \
    apt install -y libasound2-dev && \
    apt install -y --no-install-recommends xfce4 && \
    apt install -y --no-install-recommends xdg-utils && \
    apt-get install -y tigervnc-standalone-server && \
    apt install -y tigervnc-common && \ 
    apt install -y gnome-terminal && \
    apt install -y procps


ENV DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901 \
    VNC_COL_DEPTH=32 \
    VNC_RESOLUTION=1920x1080


COPY ./entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]