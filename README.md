# Pre-installation
In the latest Arch Linux ISO
## Connect to the internet
Find device name
```
root@archiso ~ # ip addr show
```
2: wlan0: ...

```
root@archiso ~ # iwctl --passphrase <passphrase> station wlan0 connect NetworkName
```
# Guided installation
Archinstall ships with a pre-programmed Guided Installer guiding you through the mandatory steps as well as some optional configurations that can be done.   
To start the installer, run

```
root@archiso ~ # archinstall
```

Note, set  
"bootloader": "Grub"
since we will use grub-btrfs later
otherwise my choice, see [install.log](https://github.com/holmen1/dot-files/blob/master/edited_install.log)  


# Post-installation

## DISASTER RECOVERY
Restore Timehift snapshots with grub-btrfs

Install Timeshift
```
$ pacman -S timeshift
```
and setup schedule, then enable schedule

```
$ systemctl enable --now cronie.service
```
 

list snaphots
```
$ sudo btrfs subvolume list /
```

ID 261 gen 17 top level 256 path timeshift-btrfs/snapshots/2024-10-24_01-34-59/@/var/lib/portables  
ID 262 gen 17 top level 256 path timeshift-btrfs/snapshots/2024-10-24_01-34-59/@/var/lib/machines  
ID 263 gen 132 top level 5 path timeshift-btrfs/snapshots/2024-10-24_00-41-32/@   

Install grub-btrfs  
```
$ sudo pacman -S grub-btrfs
```

### Manually generate grub snapshot entries
run
```
$ sudo /etc/grub.d/41_snapshots-btrfs
```
which updates grub-btrfs.cfg  

You then need to regenerate the GRUB configuration by running the following command

```
$ sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### Automatically update grub
upon snapshot creation or deletion  

By default the daemon is watching the directory /.snapshots. If the daemon should watch a different directory,  
it can be edited with
```
$ sudo systemctl edit --full grub-btrfsd
```

Set  
ExecStart=/usr/bin/grub-btrfsd --syslog --timeshift-auto  

That will automatically detect Timeshifts snapshot directory

Also need to monitor changes to the filesystem, and report those changes to applications
```
$ sudo pacman -S inotify-tools
```

Finally activate grub-btrfsd during system startup
```
$ sudo systemctl enable grub-btrfsd
```

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

### yay
yay automates usage of the Arch User Repository
```
$ sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```



### Optional packages

#### Visual Studio Code
Download tar.gz

Move
```
$ sudo mv Downloads/VSCode-linux-x64/ /opt/
```

Link
```
$ sudo ln -s /opt/VSCode-linux-x64/bin/code /usr/local/bin/code
```


## VPN
$ yay -S mullvad-vpn-bin
