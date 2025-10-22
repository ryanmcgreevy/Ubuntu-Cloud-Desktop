#!/bin/bash


USER=ubuntu
GRDPORT=3389

#EC2_INSTANCE_ID="`wget -q -O - http://instance-data/latest/meta-data/instance-id || die \"wget instance-id has failed: $?\"`"
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
EC2_INSTANCE_ID=`curl -H "X-aws-ec2-metadata-token: ${TOKEN}" http://169.254.169.254/latest/meta-data/instance-id`

RDP_PASS=$EC2_INSTANCE_ID
RDP_USER=$USER

# sudo -u gnome-remote-desktop winpr-makecert3 -silent -rdp -path ~gnome-remote-desktop rdp-tls
# sudo grdctl --system rdp set-tls-key ~gnome-remote-desktop/rdp-tls.key
# sudo grdctl --system rdp set-tls-cert ~gnome-remote-desktop/rdp-tls.crt
# sudo grdctl --system rdp enable
sudo grdctl --system rdp set-credentials "${RDP_USER}" "${RDP_PASS}"
sudo systemctl --now restart gnome-remote-desktop.service
#echo $RDP_PASS | sudo passwd $RDP_USER --stdin

echo "
<user-mapping>

    <!-- Per-user authentication and config information -->
    <authorize username=\"${USER}\" password=\"${EC2_INSTANCE_ID}\">
        <protocol>rdp</protocol>
        <param name=\"hostname\">localhost</param>
        <param name=\"port\">${GRDPORT}</param>
        <param name=\"password\">${EC2_INSTANCE_ID}</param>
    </authorize>

</user-mapping>
" | sudo tee /etc/guacamole/user-mapping.xml

#start guacamole server in case it hasn't already started
sudo guacd

