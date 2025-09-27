#Ubuntu Cloud Desktop

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

Images created with this process are available on the [AWS Marketplace](https://aws.amazon.com/marketplace/seller-profile?id=95e6927a-d15d-4043-92c7-1408cabec49a).