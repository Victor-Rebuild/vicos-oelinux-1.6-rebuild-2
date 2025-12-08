# vicos-1.6-rebuild-2

## Prebuilt OTA:

Not yet

The actual latest dev OTA is available here: [http://ota.pvic.xyz/vic/latest/dev.ota](http://ota.pvic.xyz/vic/latest/dev.ota)

## Build

- WireOS must be built on Linux, either x86_64 or aarch64.
- Minimum specs:
    -   x86_64 or aarch64 CPU
    -   4 cores
    -   8 GB of RAM
    -   100 GB of free storage
- Recommended specs:
    -   x86_64 CPU
    -   8 or more cores
    -   16 or more GB of RAM
    -   200 or more GB of free storage
- A minimum spec machine might take up to 3 hours to build a full OTA. A beefy one takes around half an hour.
- It is recommended to build WireOS on an x86_64 CPU via the Docker method.
- If you want to build on aarch64, you have to go the bare metal route. The Docker method cannot be used for aarch64 build machines yet.
- **Asahi Linux cannot be used to build WireOS.** 99% of the build happens, but it fails during one of the final in-image configuration stages due to an Asahi-specific issue with `qemu-arm`.
    -   I had success building WireOS in a Debian VM on my M3 Macbook Air using UTM. A QEMU+KVM VM in Asahi would probably work too.
- **Click an option below.**

<details>
<summary><strong>Build in Docker (recommended) (x86_64 only)</strong></summary>
<br />

- **You do not need to make a container yourself. Just follow these steps. The build script handles it for you.**

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

</details>

<details>
<summary><strong>Build on bare metal (x86_64 and aarch64)</strong></summary>

- Note: Yocto flips out if you try to use Python via a pyenv. Make sure you are using the OS's native Python only.

1. Run a [distribution supported by Yocto](https://docs.yoctoproject.org/dev/ref-manual/system-requirements.html#supported-linux-distributions).
    -   I recommend Debian 12 and up or Ubuntu 22.04 and up. Anything in this list with a glibc version 2.35 or above should work.
    -   Arch Linux seems to work too.

2. Install the required packages:

- Debian/Ubuntu
```
sudo apt install -y build-essential chrpath cpio debianutils diffstat expect file git iputils-ping libacl1 locales python3 python3-git python3-jinja2 python3-pexpect python3-subunit socat unzip wget xz-utils zstd gnupg flex bison gperf zip curl zlib1g-dev libncurses5-dev x11proto-core-dev libx11-dev libxml-simple-perl libc6-dev libgl1-mesa-dev tofrodos libxml2-utils xsltproc genisoimage gawk p7zip-full android-sdk-libsparse-utils ruby subversion libssl-dev protobuf-compiler pkg-config nano ninja-build clang ccache libc++-dev rsync cmake automake libtool
```

3. Clone and build (***with -nd flag***):
```
git clone https://github.com/os-vector/wire-os --recurse-submodules
cd wire-os
./build/build.sh -nd -bt dev -v <build-increment>
# build-increment can be any number you want. it will be the final number of the OTA: 3.0.1.<incrememnt>.ota
```

</details>

### Where is my OTA?

`./_build/1.6.1.1.ota`

## build.sh flags

```
-bt <build-type>
    required. build-type: [dev|oskr]
    dev is recommended. if you unlocked a bot with unlock-prod-*.ota, use that
-v <increment>
    required. increment: [any int 0-9999]
    (final file will be 3.0.1.<build increment>.ota)
-bp <password>
    boot image signing password: [string]
    not required for dev builds
-nd
    build on bare metal rather than in Docker
-ui <ui-option>
    use a different Yocto UI: [knotty|taskexp|taskexp_ncurses|ncurses|teamcity]
    default is knotty. ncurses is cool but requires you to CTRL+C after completion.
    only add this argument if you know what you are doing.
```

## Rebuilds

- Wire tries to make it so whenever changes are made, you don't need to do a full rebuild; however, due to this being synced up to poky's `master` branch, behavior can be unpredictable. **Due to this, I recommend doing a full rebuild each time.** You can clean your build directory by running `sudo rm -rf poky/build/tmp-glibc poky/build/cache poky/build/sstate-cache poky/build/downloads`.

## Donate

I don't have any donations, please donate to wire via the link below instead

[![Buy Wire A Coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://buymeacoffee.com/kercre123)
