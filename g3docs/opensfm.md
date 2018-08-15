# OpenSFM Docker file python2

Runs Opensfm on python2.

## Step 1: Build docker image

From the root of the repo, run:
`docker build -t iitmcvg/opensfm opensfm`

## Step 2: Run container

Run

```
nvidia-docker run -it --rm --name $USERNAME \
-p 1002:22 \
-e USERNAME=$USERNAME \
-v /media/home/$USERNAME$:/home/$USERNAME \
-v /media/ssd/$USERNAME$:/mnt/ssd \
iitmcvg/opensfm bash
```


