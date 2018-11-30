# VNC

We've allowed for vnc access to containers when you need to show windows.

However, since this occupies GPU memory, we recommend this be done only if absolutely needed.

The instructions in this document have been verified for Ubuntu 16.04 and 18.04.

## Procedure

### Install a Desktop

#### Recommended: Xfce4

On your container, install the Xfce and TightVNC packages.


```
sudo apt-get update
sudo apt install xfce4 xfce4-goodies tightvncserver
```

#### I love ubuntu ...

(Works only for ubuntu  16.04 LTS and earlier, so don't use this if you're container is 18.04)

```
sudo apt-get install --no-install-recommends ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
```

Not Unity, but GNOME.

#### No MATE rocks ...

Works on all ubuntu LTS versions.

```
sudo apt-get install mate-desktop-environment-core
```

### Install a VNC Server and ... Kill It

Install vnc4server:

```
sudo apt-get install vnc4server
```

You could also try tightvncserver (light, but lacks features) or tigercvnc (need to use `sudo dpkg -i <deb file>`).

Run `vncserver` and configure your password.

Now kill the session with `vncserver -kill :1`.

### Configure your xstartup file

Edit `~/.vnc/xstartup`:

Paste the following:
 
```
#!/bin/sh
# Uncomment the following two lines for normal desktop:
def
export XKL_XMODMAP_DISABLE=1
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

xrdb $HOME/.Xresources
xsetroot -solid grey
dbus-launch xfce4-session
```

For gnome:

```
#!/bin/sh

# Uncomment the following two lines for normal desktop:
# unset SESSION_MANAGER
# exec /etc/X11/xinit/xinitrc

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &
x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &
x-window-manager &

gnome-panel &
gnome-settings-daemon &
metacity &
nautilus &
```

For mate:

```
#!/bin/sh

# Uncomment the following two lines for normal desktop:
# unset SESSION_MANAGER
# exec /etc/X11/xinit/xinitrc

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &
x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &
x-window-manager &
exec /usr/bin/mate-session &   
```

Refer trouble shooting if while running the VNC client you see the grey screen of doom.

### Install a VNC Client

There are many including:

* Recommended: [RealVNC](https://www.realvnc.com/en/connect/download/)
* Tightvnc Client
* Tigervnc Client

### Start a VNC Desktop

Run :

```
vncserver --geometery {width}x{height} :x
```
Where,

* width and height are optimised (not necessary, but recommended)
* x is the desktop number

Your port to connect would be `5900 + x`.

### Tunnel the port

We wont be exposing VNC ports for your container (not secure).

So (reverse) tunnel them  instead:

```
ssh -Nf -L <your port1>:localhost:<container port 1> -L <your port2>:localhost:<container port 2> -p <PORT> user@IP
```

Log on to the IP: PORT, PORT which is mapped for your container, with the required password.

## Trouble Shooting

### Grey Screen of Doom

* Ensure you have all the packages, eg: gnome panel, settings etc.
* View logs under `~/.vnc/<host>:x.log` and find the package which doesnt load. Determine whether it needs to be installed.
* Ensure 
```gnome-panel &
gnome-settings-daemon &
metacity &
nautilus &
```
is included for gnome

* Ensure your `depth` flag is valid for the viewer. (if using any)
* Ensure the startup script is executable. `chmod +x ~/.vnc/xstartup`.
* Stackoverflow to the rescue!

## References

1. [Qxf2 Blog](https://qxf2.com/blog/view-docker-container-display-using-vnc-viewer/)
2. [Digital Ocean for Xfce4](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-ubuntu-18-04)
3. [Linux Everday on Ubuntu Mate](http://www.linuxeveryday.com/2017/09/install-configure-vnc-server-ubuntu-mate)
4. [Linode for GNOME](https://www.linode.com/docs/applications/remote-desktop/install-vnc-on-ubuntu-16-04/)

