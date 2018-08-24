# Redtail

Setup for the redtail containers

## Usage

### Step 1: Build container

Log in to NGC

```
docker login nvcr.io
Username: $oauthtoken
Password: <Your Key>
```

```
docker build -t iitmcvg/redtail redtail
```

### Step 2: Run container

```
nvidia-docker run -it -d --name uav \
--privileged \
--network=host \
-p 7002:22 \
-e USERNAME=uav \
-v /media/home/uav:/home/uav \
-v /media/ssd/uav:/mnt/ssd \
-v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix${DISPLAY} -p 14556:14556/udp \
iitmcvg/redtail bash
```

### Step 3: run

```
XAUTH=$HOME/.Xauthority
touch $XAUTH
```

