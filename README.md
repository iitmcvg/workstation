# README

Dockerfiles used for our workstations and user specific dockerfiles.

## Root Image

Define :

```
* PORT (port to use for ssh)
* HOME MOUNT (mounts and backs up home folder)
* SSD MOUNT (mounts SSD for binaries)
* D_USERNAME 
```

Run

```
nvidia-docker run -it -d --name $D_USERNAME \
-p $PORT:22 \
-e USERNAME=$D_USERNAME \
-v $HOME_MOUNT$:/home/$D_USERNAME \
-v $SSD_MOUNT:/mnt/ssd \
iitmcvg/workstation bash
```

NGC- python3 Tensorflow based.

Required nvidia-docker for GPU runs.

Tested with nvidia-drivers (384,387,390,394)

Packages:
    * sudo  
    * git   
    * wget   
    * zsh   
    * vim   
    * zsh   
    * htop   
    * imagemagick   
    * fdupes   
    * libcurl4-gnutls-dev   
    * wget   
    * openssh-server   
    * curl 

### Entrypoint script

Sets username, passwords.

Recommended to change from default to SSH-Keys.

Also exports `HOME`, `PATH`, `LD_LIBRARY_PATH`.

## Running User-Specific Images

Replace `iitmcvg/workstation` by `iitmcvg/workstation#master:dir`.

Can use other branches if available.

Run (eg):

```
nvidia-docker run -it --rm --name $USERNAME \
-p 18888:8888 -p 1002:22 -p 16006:6006 -p 1010-1100:1010-1100 \
-e USERNAME=$USERNAME \
-v /media/home/$USERNAME$:/home/$USERNAME \
-v /media/ssd/$USERNAME$:/mnt/ssd \
iitmcvg/workstation/#master:torch bash
```
