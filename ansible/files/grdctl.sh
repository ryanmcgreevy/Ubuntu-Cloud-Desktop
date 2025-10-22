sudo -u gnome-remote-desktop winpr-makecert3 -silent -rdp -path ~gnome-remote-desktop rdp-tls
sudo grdctl --system rdp set-tls-key ~gnome-remote-desktop/rdp-tls.key
sudo grdctl --system rdp set-tls-cert ~gnome-remote-desktop/rdp-tls.crt
sudo grdctl --system rdp enable
sudo systemctl --now enable gnome-remote-desktop.service