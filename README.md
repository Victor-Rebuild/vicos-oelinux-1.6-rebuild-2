# vicos-1.6-rebuild-2

## Prebuilt OTA:

Not yet

## Build

- Note: you will need a somewhat beefy **x86_64 Linux** machine with at least 16GB of RAM and 100GB of free space.

1. [Install Docker](https://docs.docker.com/engine/install/), git, and wget.

2. Configure Docker so a regular user can use it:

```
sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker
sudo chown root:docker /var/run/docker.sock
sudo chmod 660 /var/run/docker.sock
```

3. Clone and build:

```
git clone https://github.com/Victor-Rebuild/vicos-oelinux-1.6-rebuild-2 --recurse-submodules
cd vicos-oelinux-1.6-rebuild-2
./build/build.sh -bt <dev/oskr> -bp <boot-passwd> -v <build-increment>
# boot password not required for dev
# example: ./build/build.sh -bt dev -v 1
# <build-increment> is what the last number of the version string will be - if it's 1, it will be 1.6.1.1.ota
```

### Where is my OTA?

`./_build/1.6.1.1.ota`

## Rebuilds

- Wire tries to make it so whenever changes are made, you don't need to do a full rebuild; however, due to this being synced up to poky's `master` branch, behavior can be unpredictable. **Due to this, I recommend doing a full rebuild each time.** You can clean your build directory by running `sudo rm -rf poky/build/tmp-glibc poky/build/cache poky/build/sstate-cache poky/build/downloads`.

##  Donate

I don't have any donations, please donate to wire via the link below instead

[![Buy Wire A Coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://buymeacoffee.com/kercre123)
