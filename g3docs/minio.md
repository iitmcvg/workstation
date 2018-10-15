# Minio 

Minio docs: [here](https://docs.minio.io/docs/minio)

## Client Side

Open IP:9000

See this: [link](https://docs.minio.io/docs/minio-client-quickstart-guide.html)

### Add config (CLI)



### Copying files



## Server Side

Run:

```
docker run -p 9000:9000 -it -d --name minio1 \
  -e "MINIO_ACCESS_KEY=iitmcvg" \
  -e "MINIO_SECRET_KEY=iitmcvg/minio/usb1" \
  -v /media/iitmcvg/VARUN_CVI:/data \
  -v /mnt/config:/root/.minio \
  minio/minio server /data
```