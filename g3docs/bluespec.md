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

Allow for xhost access.

`xhost + 127.0.0.1`

Allow for xquartz access: 
* Install the latest XQuartz X11 server and run it
* Activate the option ‘Allow connections from network clients’ in XQuartz settings
* Quit & restart XQuartz (to activate the setting)

```
docker run -ti -d --name bluespec-varun \
-v /abs/path/to/bluespec-mount:/home/varun \
-p 11002:22 \
-e USERNAME=varun \
-e DISPLAY=docker.for.mac.localhost:0 \
-v /tmp/.X11-unix:/tmp/.X11-unix \
iitmcvg/bluespec bash
```

## 4. Run the container

Run `docker attach bluespec-varun`
Run `export DISPLAY=docker.for.mac.localhost:0`
Run `bluespec &` 