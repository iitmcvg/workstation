# Blue Spec install

## 1. Build Docker file

`docker build -t iitmcvg/bluespec bluespec`

## 2. Export Bashrc paths

To `bluespec-mount`,

create `.bashrc` and add:

```
export BLUESPEC_HOME=/home/tlokeshkumar/Bluespec-2017.07.A
export BLUESPECDIR=$BLUESPEC_HOME/lib
export PATH=$PATH:$BLUESPEC_HOME/bin
export LM_LICENSE_FILE=27000@192.168.1.8:28000@10.21.226.183
```

## 3. Mount bluespec volume to /home/user

`IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')`

```
docker run -ti -d --name bluespec-varun \
-v ~/bluespec-mount:/home/varun \
-p 11002:22 \
-e USERNAME=varun \
-e DISPLAY=$IP:0 \
-v /tmp/.X11-unix:/tmp/.X11-unix \
iitmcvg/bluespec bash
```

`xhost + $IP`

## 4. Run container

Run `docker attach bluespec-varun`
Run `bluespec &` 