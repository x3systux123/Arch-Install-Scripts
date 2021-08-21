#!/bin/bash
echo
echo This is are Arch Linux install script made by x3!;
echo;
echo;
echo;
#list all hard drives in your system
lsblk;
echo;
echo select the drive for the system: "/dev/sd";
read hardrive;
cfdisk $hardrive;
brake;
clear;
lsblk;
echo;
echo please select your swap partition;
read swap;
mkswap -L swap $swap;
echo;
echo please select your root partition;
read root;
mkfs.ext4 -L root $root;
clear;
echo now we can install the base system;
mount -L root /mnt;
swapon -L swap;
pacstrap /mnt base base-devel linux linux-firmware dhcpcd nano;
echo;
echo -n "Enter your ucode: "
echo "1) intel-ucode"
echo "2) amd-ucode"
read ucode
if [[ $ucode -gt 1 ]]
then
    pacman --root /mnt -S amd-ucode
else
    pacman --root /mnt -S intel-ucode
fi;
clear;
genfstab -U /mnt > /mnt/etc/fstab;
pacman -Sy git;
git clone https://github.com/x3systux123/Arch-Install-Scripts.git;
cd Arch-Install-Scripts;
mv arch-chroot-install.sh /mnt/;
echo export PS1="[chroot] ${PS1}" > /mnt/root/.bashrc;
echo alias setup='cd / && bash arch-chroot-install.sh' > /mnt/root/.bashrc;
arch-chroot /mnt;
