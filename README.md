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
iwctl station wlan0 scan
iwctl station wlan0 get-networks
```

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
"profile": "Xorg"

otherwise my choice, see [install.log](https://github.com/holmen1/dot-files/blob/master/log/install.log)  


# Post-installation

## Automation scripts

* configure Git and generate SSH keys
```
./scripts/gitconfig.sh
```
* install packages from pkglist.txt and foreignpkglist.txt
```
./scripts/install_packages.sh
```
* link configuration dotfiles to ~/.config

```
$ ln -s ~/repos/archinstall/dotfiles/xmonad ~/.config/xmonad
$ ln -s ~/repos/archinstall/dotfiles/xmobar ~/.config/xmobar
$ ln -s ~/repos/archinstall/dotfiles/.xinitrc ~/.xinitrc
$ ln -s ~/repos/archinstall/dotfiles/.bashrc ~/.bashrc
```

## Git
After you generate an SSH key pair, you must add the public key to GitHub.com to enable SSH access for your account


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


## Packages

### Export installed packages
Keeping a list of all explicitly installed packages can be useful to backup a system or quicken the installation of a new one
```
$ ./scripts/export_packages.sh
```
creates files pkglist.txt and foreignpkglist.txt in the packages directory


### Optional packages

#### Visual Studio Code
Download tar.gz

```
$ tar -xvzf code-stable-x64-1734606550.tar.gz 
```
Move
```
$ sudo mv Downloads/VSCode-linux-x64/ /opt/
```

Link
```
$ sudo ln -s /opt/VSCode-linux-x64/bin/code /usr/local/bin/code
```
## Xmonad
xmonad is a tiling window manager for X. Windows are arranged automatically to tile the screen without gaps or overlap, maximizing screen use
, here configured with xmobar to provide a status bar  

[README](https://github.com/holmen1/archinstall/blob/xmonad/dotfiles/xmonad/README.md)

## kitty
[README](https://github.com/holmen1/archinstall/blob/desktop/dotfiles/kitty/README.md)

## neovim
[README](https://github.com/holmen1/archinstall/blob/desktop/dotfiles/nvim/README.md)



# LESSONS LEARNED

## Opacity
Need xcompmgr for fadeWindowsLogHook to work

## lspconfig
```
yay -S unzip
```
luastyles: failed to install


## Automated installation with archinstall
-Boot from the Arch Linux ISO
-Connect to the internet
-Download config.json
```
$ curl -O https://github.com/holmen1/archinstall/blob/master/log/config.json
```
-Run the installer
```
$ archinstall --config config.json
```




## TODO



### Install
* [ ] Network manager
* [ ] Neovim
* [ ] Install script

