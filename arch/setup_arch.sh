# my typical settings with arch:
# set up the GPT like so:
# Number Start (sector) End (sector) Size Code Name
# 4      34             2047              EF02 Boot
# 1      2048           1050624           EF00 EFI System
# 2      1052672        3149824           8200 Linux Swap

echo "Making main linux filesystem partition..."
mkfs -t ext4 /dev/sda3
echo "Making swap space..."
mkswap /dev/sda2

echo "Mounting filesystem..."
mount /dev/sda3 /mnt

echo "Bootstrapping arch..."
pacstrap /mnt base

# you have to do arch-chroot before you continue further
arch-chroot /mnt

# no luck with grub. Just going to use syslinux:
syslinux-install_update -iam

# dhcpcd <- to connect to wired interfaces 
