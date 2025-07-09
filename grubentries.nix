
{ config, ... }:

{

boot.loader.grub.extraEntries = ''

menuentry 'Windows Boot Manager (on /dev/nvme0n1p1)' --class windows --class os {
	insmod part_gpt
	insmod fat
	search --no-floppy --fs-uuid --set=root 20C7-A651
	chainloader /efi/Microsoft/Boot/bootmgfw.efi
}
menuentry "Nobara Linux" {
        insmod part_gpt
        insmod ext2
        search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt4 --hint-efi=hd0,gpt4 --hint-baremetal=ahci0,gpt4  19de8f98-898f-46c2-943e-fb1a977d1d28
        linux /boot/vmlinuz-6.14.6-200.nobara.fc42.x86_64 root=UUID=19de8f98-898f-46c2-943e-fb1a977d1d28 rw quiet loglevel=3
        initrd /boot/initramfs-6.14.6-200.nobara.fc42.x86_64.img
}
menuentry 'UEFI Firmware Settings' {
	fwsetup
}
menuentry "Shutdown" --class shutdown {
	echo "System shutting down..."
	halt
}

menuentry "Restart" --class restart {
	echo "System rebooting..."
	reboot
}

'';  

}
