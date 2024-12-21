# Pre-installation
In the latest Arch Linux ISO

## Set the console keyboard

```
loadkeys sv-latin1
```
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
otherwise my choice, see [install.log](https://github.com/holmen1/dot-files/blob/master/log/install.log)  


# Post-installation
## REPAIR
On a Btrfs root file system with subvolumes, you have to make sure that all subvolumes are properly mounted
as specified in fstab before entering chroot

```
root@archiso ~ # fdisk -l
/dev/nvme0n1p1    2048    2099199   2097152     1G EFI System
/dev/nvme0n1p2 2099200 1000213167 998113968 475.9G Linux root (x86-64)
```

```
# mount -o subvol=@ /dev/nvme0np2 /mnt
# mount -o subvol=@home /dev/nvme0np2 /mnt/home
```

```
# lsblk 
```

```
# arch-chroot /mnt
```

chroot to user
```
[root@archiso /]# su - holmen1
```


```
[root@archiso /]# exit
# cd /
# umount --recursive /pa
```

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

ID 278 gen 1830 top level 5 path timeshift-btrfs/snapshots/2024-10-26_13-06-21/@  
ID 279 gen 1830 top level 5 path timeshift-btrfs/snapshots/2024-10-26_14-12-13/@  
ID 280 gen 1926 top level 5 path timeshift-btrfs/snapshots/2024-10-26_15-15-43/@

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

## Bluetoth

```
$ sudo systemctl status bluetooth
```
```
$ sudo systemctl start bluetooth
```
```
$ sudo systemctl enable bluetooth
```


## Packages
List of installed packages

Keeping a list of all explicitly installed packages can be useful to backup a system or quicken the installation of a new one

### Export
```
$ pacman -Qqetn > ~/repos/archinstall/packages/pkglist.txt
```
option -t, the packages already required by other explicitly installed packages are not mentioned  
option -n, foreign packages (e.g. from AUR) would be omitted from the list
```
$ pacman -Qqem > ~/repos/archinstall/packages/foreignpkglist.txt
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
## kitty
[README](https://github.com/holmen1/dot-files/tree/master/kitty)

## neovim
[README](https://github.com/holmen1/dot-files/tree/master/nvim)


## GitHub Copilot in the CLI
Get gh binary https://github.com/cli/cli/releases/tag/v2.60.1

```
$ gh auth login
```
```
$ gh extension install github/gh-copilot
```
```
$ gh copilot explain "sudo pacman -Syu"
```
Welcome to GitHub Copilot in the CLI!  
version 1.0.5 (2024-09-12)  

I'm powered by AI, so surprises and mistakes are possible. Make sure to verify any generated code or suggestions, and share feedback so that we can learn and improve. For more information, see https://gh.io/gh-copilot-transparency

Explanation:                                                                      
                                                                                  
  • sudo is used to run a command with elevated rights.                           
    • pacman is the package manager used in Arch Linux and its derivatives.       
      • -Syu is a combination of flags:                                           
        • -S synchronizes the package databases, updating them to the latest      
        version.                                                                  
        • -y automatically answers "yes" to any prompts, allowing the upgrade to  
        proceed without user intervention.                                        
        • -u upgrades all installed packages to their latest versions. 


## VPN
$ yay -S mullvad-vpn-bin

# LESSONS LEARNED

## Unable to delete timeshift btrfs snapshot

https://bbs.archlinux.org/viewtopic.php?id=266965

Try
```
$ sudo timeshift --delete --snapshot '2024-10-24_01-34-59'
```
Deleting subvolume: @ (Id:256)  
E: ERROR: Could not destroy subvolume/snapshot: Directory not empty


```
$ sudo btrfs subvolume list /
```
ID 256 gen 1796 top level 5 path timeshift-btrfs/snapshots/2024-10-24_01-34-59/@  
ID 257 gen 1830 top level 5 path @home  
ID 258 gen 1830 top level 5 path @log  
ID 259 gen 1667 top level 5 path @pkg  
ID 260 gen 1456 top level 5 path @.snapshots  
ID 261 gen 17 top level 256 path timeshift-btrfs/snapshots/2024-10-24_01-34-59/@/var/lib/portables  
ID 262 gen 17 top level 256 path timeshift-btrfs/snapshots/2024-10-24_01-34-59/@/var/lib/machines  
ID 264 gen 1830 top level 5 path @  
ID 278 gen 1830 top level 5 path timeshift-btrfs/snapshots/2024-10-26_13-06-21/@  
ID 279 gen 1830 top level 5 path timeshift-btrfs/snapshots/2024-10-26_14-12-13/@  

Naive attempt
```
$ sudo btrfs subvolume delete timeshift-btrfs/snapshots/2024-10-24_01-34-59/@
```
ERROR: Could not statfs: No such file or directory

Need full path: /run/timeshift/1555/backup/timeshift-btrfs...
NB Timeshift need to run to get XXXX above

Delete, beginning with subsubvolumes
```
$ sudo btrfs subvolume delete /run/timeshift/1555/backup/timeshift-btrfs/snapshots/2024-10-24_01-34-59/@/var/lib/portables
$ sudo btrfs subvolume delete /run/timeshift/1555/backup/timeshift-btrfs/snapshots/2024-10-24_01-34-59/@/var/lib/machines
$ sudo btrfs subvolume delete /run/timeshift/1555/backup/timeshift-btrfs/snapshots/2024-10-24_01-34-59/@
```

Then delete
```
$ sudo timeshift --delete --snapshot '2024-10-24_01-34-59'
```
