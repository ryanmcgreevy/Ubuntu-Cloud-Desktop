# Ubuntu Cloud Desktop

Terraform and Ansible files for provisioning and configuration management of
Amazon Web Services (AWS) Elastic Compute Cloud (EC2) images for
[Panoptesoft, LLC](https://panoptesoft.com/).

Terraform is used to provision and tag the EC2 instances while Ansible
configures the instance for use as a virtual desktop. This 
process includes installing and configuring x11VNC, Apache Tomcat and Guacamole,
and video drivers and associated X11 configurations for remote desktop. The image
created from this configured instance can be used as a remote cloud desktop 
with support for 3D applications utilizing OpenGL and GLX. The instances can be
accessed through either a VNC client or through a web browser.

Starting with Ubuntu 25.10, Canonical has dropped support for x11 in favor of Wayland. This
has necessitated a shift of the underlying software stack to use Gnome Remote Desktop. Additionally,
ongoing compatibility issues with Apache Guacamole and Tomcat has required a change in how
Guacamole is installed and configured on the image. For now, the guacd daemon is being used
through the official Docker container image.

Images created with this process are available on the [AWS Marketplace](https://aws.amazon.com/marketplace/seller-profile?id=95e6927a-d15d-4043-92c7-1408cabec49a).