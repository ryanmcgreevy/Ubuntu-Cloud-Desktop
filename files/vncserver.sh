#!/bin/bash

# The Username:Group that will run VNC
export USER="ubuntu"


# The display that VNC will use
DISPLAY="0"

# VNC Port to listen on
VNCPORT="5900"
#EC2_INSTANCE_ID="`wget -q -O - http://instance-data/latest/meta-data/instance-id || die \"wget instance-id has failed: $?\"`"
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
EC2_INSTANCE_ID=`curl -H "X-aws-ec2-metadata-token: ${TOKEN}" http://169.254.169.254/latest/meta-data/instance-id`

# Detect NVIDIA driver
nvidia_driver=`dpkg --get-selections | awk '/nvidia-[0-9]+\t+install/ { print $1 }'`

MYHOME="$(sudo -u ${USER} /usr/bin/env | grep "^HOME="  | cut -d = -f2)"
export HOME=$MYHOME
#sudo -u ${USER} rm -f $HOME/.Xauthority*
sudo -u ${USER} rm -f $HOME/.vnc/passwd
sudo -u ${USER} echo "${EC2_INSTANCE_ID}" | /usr/bin/tightvncpasswd -f > $HOME/.vnc/passwd

echo "
<user-mapping>

    <!-- Per-user authentication and config information -->
    <authorize username=\"${USER}\" password=\"${EC2_INSTANCE_ID}\">
        <protocol>vnc</protocol>
        <param name=\"hostname\">localhost</param>
        <param name=\"port\">${VNCPORT}</param>
        <param name=\"password\">${EC2_INSTANCE_ID}</param>
    </authorize>

</user-mapping>
" > /etc/guacamole/user-mapping.xml


GPUCHECK="$(lspci)"
if [[ $GPUCHECK =~ "NVIDIA" ]]; then
   sudo cp /etc/X11/xorg.conf.nvidia /etc/X11/xorg.conf
   sudo update-alternatives --set i386-linux-gnu_gl_conf /usr/lib/${nvidia_driver}/alt_ld.so.conf
   sudo update-alternatives --set i386-linux-gnu_egl_conf /usr/lib/${nvidia_driver}/alt_ld.so.conf
   sudo update-alternatives --set x86_64-linux-gnu_gl_conf /usr/lib/${nvidia_driver}/ld.so.conf
   sudo update-alternatives --set x86_64-linux-gnu_egl_conf /usr/lib/${nvidia_driver}/ld.so.conf
else
   sudo cp /etc/X11/xorg.conf.nogpu /etc/X11/xorg.conf
   sudo update-alternatives --set i386-linux-gnu_gl_conf /usr/lib/i386-linux-gnu/mesa/ld.so.conf
   sudo update-alternatives --set i386-linux-gnu_egl_conf /usr/lib/i386-linux-gnu/mesa-egl/ld.so.conf
   sudo update-alternatives --set x86_64-linux-gnu_gl_conf /usr/lib/x86_64-linux-gnu/mesa/ld.so.conf
   sudo update-alternatives --set x86_64-linux-gnu_egl_conf /usr/lib/x86_64-linux-gnu/mesa-egl/ld.so.conf
fi

#sudo -u ${USER} /usr/bin/xinit -display :${DISPLAY} &
/usr/bin/x11vnc -rfbauth $HOME/.vnc/passwd -rfbport ${VNCPORT} -display :${DISPLAY} -repeat -forever -loop -xrandr newfbsize -o /var/log/vnc.log -noxrecord
