echo "please select your hostname: ";
read hostname;
echo $hostname > /etc/hostname;
clear;
echo LANG=de_DE.UTF-8 > /etc/locale.conf;
echo en_US.UTF-8 UTF-8 > /etc/locale.gen;
locale-gen;
echo "please tipe your Timezone z.B Berlin,Amsterdam etc. : "
read timezone;
ln -sf /usr/share/zoneinfo/Europe/$timezone /etc/localtime;
clear;
echo [multilib] > /etc/pacman.conf;
echo SigLevel = PackageRequired TrustedOnly > /etc/pacman.conf;
echo Include = /etc/pacman.d/mirrorlist > /etc/pacman.conf;
clear;
mkinitcpio -p linux;
passwd;
clear;
pacman -S grub;
grub-install $hardrive;
gtub-mkconfig -o /boot/grub/grub.cfg;
clear;
echo "now we create your user: ";
read user;
useradd -m -g users -s /bin/bash $user;
passwd $user;
gpasswd -a $user video;
gpasswd -a $user audio;
gpasswd -a $user wheel;
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers;
systemctl enable --now fstrim.timer;
pacman -S acpid dbus avahi cups;
systemctl enable acpid;
systemctl enable avahi-daemon;
systemctl enable cups.service;
systemctl enable --now systemd-timesyncd.service;
echo -n "Enter your Videodriver: "
echo "1) nvidia"
echo "2) amd"
read videodriver
if [ "$videodriver" = "nvidia" ] 
then
    pacman -S nvidia nvidia-settings
else
    pacman -S xf86-video-amdgpu
fi;
pacman -S plasma plasma-desktop plasma-meta dolphin konsole;
systemctl enable sddm;
exit;
umount -R /mnt;
swapoff -L swap;
clear;
reboot;


