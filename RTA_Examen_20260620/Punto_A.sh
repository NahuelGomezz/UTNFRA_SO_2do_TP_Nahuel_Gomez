#!/bin/bash
sudo fdisk /dev/sdc
sudo fdisk /dev/sdd
sudo wipefs -a /dev/sdc1 /dev/sdd1
sudo pvcreate /dev/sdc1 /dev/sdd1
sudo vgcreate vg_datos /dev/sdc1
sudo vgcreate vg_temp /dev/sdd1
sudo lvcreate -L 5M vg_datos -n lv_docker
sudo lvcreate -L 1.5G vg_datos -n lv_workareas
sudo lvcreate -L 512M vg_temp -n lv_swap
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_docker
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_workareas
sudo mkswap /dev/mapper/vg_temp-lv_swap
sudo swapon /dev/mapper/vg_temp-lv_swap
sudo mkdir -p /var/lib/docker/
sudo mkdir -p /var/lib/docker/
sudo mkdir -p /work/
sudo mount /dev/mapper/vg_datos-lv_docker /var/lib/docker/
sudo mount /dev/mapper/vg_datos-lv_workareas /work/
sudo su -c "echo '/dev/mapper/vg_datos-lv_docker /var/lib/docker/ ext4 defaults 0 0' >> /etc/fstab"
sudo su -c "echo '/dev/mapper/vg_datos-lv_workareas /work/ ext4 defaults 0 0' >> /etc/fstab"
sudo su -c "echo '/dev/mapper/vg_temp-lv_swap none swap sw 0 0' >> /etc/fstab"
