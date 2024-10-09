rm /tmp/.X1-lock 2> /dev/null &
/opt/noVNC/utils/novnc_proxy --vnc localhost:$VNC_PORT --listen $NO_VNC_PORT &
# Insecure option is needed to accept connections from the docker host.
vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION -SecurityTypes None -localhost no --I-KNOW-THIS-IS-INSECURE &
wait