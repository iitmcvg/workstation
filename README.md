# README

Dockerfiles used for our workstations and user specific dockerfiles.

## Root Image

Run

```
nvidia-docker run -it --rm --name $USERNAME \
-p 18888:8888 -p 1002:22 -p 16006:6006 -p 1010-1100:1010-1100 \
-e USERNAME=$USERNAME \
-v /media/home/$USERNAME$:/home/$USERNAME \
-v /media/ssd/$USERNAME$:/mnt/ssd \
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