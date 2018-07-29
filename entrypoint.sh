#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

echo "Starting with UID : $USERNAME"
useradd --shell /bin/bash -o -c "" -m $USERNAME
export HOME=/home/$USERNAME
usermod -aG sudo $USERNAME
echo "$USERNAME:test" | chpasswd

exec /usr/local/bin/gosu $USERNAME "$@"
