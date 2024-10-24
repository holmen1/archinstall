# arch

## Pre-installation
In the latest Arch Linux ISO
### Connect to the internet
Find device name
```
root@archiso ~ # ip addr show
```
2: wlan0: ...

```
root@archiso ~ # iwctl --passphrase <passphrase> station wlan0 connect NetworkName
```
## Guided installation
Archinstall ships with a pre-programmed Guided Installer guiding you through the mandatory steps as well as some optional configurations that can be done.   
To start the installer, run

```
root@archiso ~ # archinstall
```

Note, set  
"bootloader": "Grub"
since we will use grub-btrfs later
otherwise my choice, see [install.log](https://github.com/holmen1/dot-files/blob/master/edited_install.log)  


## Post-installation

### yay
Yet Another Yogurt - An AUR Helper Written in Go
```
$ sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```


### Restore Timehift snapshots with grub-btrfs
when crashing (when NB)  
Install Timeshift
```
$ pacman -S timeshift
```
and setup schedule  

list snaphots
```
$ sudo btrfs subvolume list /
```

ID 260 gen 9 top level 5 path @.snapshots   
ID 261 gen 17 top level 256 path timeshift-btrfs/snapshots/2024-10-24_01-34-59/@/var/lib/portables  
ID 262 gen 17 top level 256 path timeshift-btrfs/snapshots/2024-10-24_01-34-59/@/var/lib/machines  
ID 263 gen 132 top level 5 path timeshift-btrfs/snapshots/2024-10-24_00-41-32/@  
ID 264 gen 469 top level 5 path @  
ID 265 gen 226 top level 5  

Install grub-btrfs  
```
$ sudo pacman -S grub-btrfs
```
To manually generate grub snapshot entries you can run
```
$ sudo /etc/grub.d/41_snapshots-btrfs
```
which updates grub-btrfs.cfg  

You then need to regenerate the GRUB configuration by running one of the following command

```
$ sudo grub-mkconfig -o /boot/grub/grub.cfg
```


























# arch-config

## Packages
List of installed packages

Keeping a list of all explicitly installed packages can be useful to backup a system or quicken the installation of a new one

### Export
```
$ pacman -Qqetn > pkglist.txt
```
option -t, the packages already required by other explicitly installed packages are not mentioned  
option -n, foreign packages (e.g. from AUR) would be omitted from the list
```
$ pacman -Qqem > foreignpkglist.txt
```
 to create the list of AUR and other foreign packages that have been explicitly installed

### Install

To install packages from a previously saved list of packages, while not reinstalling previously installed packages that are already up-to-date, run:
```
# pacman -S --needed - < pkglist.txt
```



## VPN
$ yay -S mullvad-vpn-bin
