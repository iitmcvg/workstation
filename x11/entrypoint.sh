#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

echo "Starting with UID : $USERNAME"
useradd --shell /bin/bash -c "" -m $USERNAME

# export paths
export HOME=/home/$USERNAME
export PATH=/home/user/bin:/usr/local/bin:/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/user/local/bin/
export LD_LIBRARY_PATH=/usr/local/cuda/extras/CUPTI/lib64:/usr/local/nvidia/lib:/usr/local/nvidia/lib64

# VNC
export DISPLAY=:20
Xvfb :20 -screen 0 1366x768x16 &
x11vnc -passwd testVNC -display :20 -N -forever &

echo "Copying zshrc's"
cp /media/home/varun/.zshrc /media/$USERNAME/.zshrc
cp -r /media/home/varun/${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions /media/home/$USERNAME/${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/

usermod -aG sudo $USERNAME

echo "$USERNAME:test" | chpasswd
service ssh restart

sudo chage -d 0 $USERNAME
exec /usr/local/bin/gosu $USERNAME "$@"

# x11 stuff
SOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
chmod 777 $XAUTH

