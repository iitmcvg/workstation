# Vanilla Dockerfile

To get you started with the following setup:

* python 3
* scientific-python (numpy, scipy, jupyter, etc)
* cmake, opencv (latest,source build)

## Usage

(On your computer, use docker or docker tool)

```
docker run -it  --name $USERNAME \
-p 18888:8888 -p 1002:22 -p 16006:6006 -p 1010-1100:1010-1100 \
-e USERNAME=$USERNAME \
-v /path/to/mount_folder:/home/$USERNAME \
-iitmcvg/workstation:vanilla bash
```

Set a mount folder on your system to back up code.

Jupyter may be accessed at port 18888, tensorboard at 16006.

Run with `-d` in case you would like to open multiple terminals. (use `docker attach iitmcvg/workstation:vanilla` for the same.

## Building from source

You can build the source too (incase the docker cloud image is outdated)

Run `docker build -t iitmcvg/workstation:vanilla vanilla` from the root of the repo.

The remaining commands are the same. 
