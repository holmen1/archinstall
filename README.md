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


## yay
$ sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

## VPN
$ yay -S mullvad-vpn-bin
