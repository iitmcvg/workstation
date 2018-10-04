echo "USER", $1
echo "IMAGE", $2

mkdir /media/home/$1
mkdir /media/ssd/$1
chmod 777 /media/home/$1
chmod 777 /media/home/$1

# Copy .zshrc
cp /media/home/varun/.zshrc /media/home/$1
cp /media/home/varun/.bashrc /media/home/$1

PORT_SSH=$3
PORT_VNC=$((PORT_SSH+1))

echo "SSH Port", $PORT_SSH
echo "VNC PORT", $PORT_VNC

nvidia-docker run -it -d --name $1 \
-p $PORT_SSH:22 -p $PORT_VNC:5920 \
-e USERNAME=$1 \
-v /media/home/$1:/home/$1 \
-v /media/ssd/$1:/mnt/$1 \
iitmcvg/$2 bash