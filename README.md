# NIX CONFIGURATION

![desktop.png](https://raw.githubusercontent.com/philopence/nix-configuration/main/extras/desktop.png)

## NOTES

- [perf: improve for source providing huge list of items](https://github.com/hrsh7th/nvim-cmp/pull/1980)
- [bug: picom 'animations' syntax error](https://github.com/nix-community/home-manager/issues/5744)
- https://github.com/nix-community/disko
- https://github.com/YaLTeR/niri
- quickfix workflow
- neogit vs lazygit
- [Interactive database client for neovim](https://github.com/kndndrj/nvim-dbee)

## Installation Guide

### STAGE 01: Live ISO -> TTY

```sh
sudo -i

systemctl start wpa_supplicant.service

wpa_cli

export https_proxy="ip:port"

export NIX_CONFIG="experimental-features = nix-command flakes"

nix shell nixpkgs#git

lsblk

## +512M EFI System
## 100%  Linux filesystem
fdisk /dev/DISK

mkfs.vfat -n BOOT /dev/ESP

mkfs.btrfs -L SYSTEM /dev/SYSTEM

mount /dev/disk/by-label/SYSTEM /mnt

btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/nix
btrfs subvolume create /mnt/persistent

umount -R /mnt

mount --mkdir -o subvol=root /dev/disk/by-label/SYSTEM /mnt
mount --mkdir -o subvol=nix /dev/disk/by-label/SYSTEM /mnt/nix
mount --mkdir -o subvol=persistent /dev/disk/by-label/SYSTEM /mnt/persistent

mount --mkdir /dev/disk/by-label/BOOT /mnt/boot

nixos-generate-config --root /mnt

## git init --initial-branch=main nix-configuration
mkdir nix-configuration

cd nix-configuration

nix flake init -t github:misterio77/nix-starter-config#standard

cp /mnt/etc/nixos/hardware-configuration.nix nixos/hardware-configuration.nix

## Fix template: flake.nix and nixos/configuration.nix
## Merge options: /mnt/etc/nixos/configuration.nix

nixos-install --no-root-passwd --flake .#hostname

## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
cp -r ../nix-configuration /mnt/persistent/nix-configuration
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

umount -R /mnt

reboot
```

### STAGE 02: TTY -> GUI

```sh
cp -r /persistent/nix-configuration ~/tmp-configuration

cd ~/tmp-configuration
```

#### home-manager

```nix
##### flake.nix #####
{
  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
}

##### nixos/configuration.nix #####
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    useGlobalPkgs = true;
    users = {
      "philopence" = import ../home-manager/home.nix;
    };
  };
}

##### home-manager/home.nix #####
{
  # FIX IT!
}
```

#### xserver or wayland

> https://bitbucket.org/natemaia/dk/src/master/

```nix
##### nixos/configuration.nix #####
{
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    windowManager.dk.enable = true;
  };
}

##### home-manager/home.nix #####
{
  ## WM config and dependencies

  xdg.configFile."dk/dkrc".source = pkgs.writeShellScript "dkrc" ''
    ## https://bitbucket.org/natemaia/dk/src/master/doc/dkrc
  '';

  xdg.configFile."sxhkd/sxhkdrc".text = ''
    ## https://bitbucket.org/natemaia/dk/src/master/doc/sxhkdrc
  '';
}
```

```sh
sudo nixos-rebuild switch --flake .#hostname

reboot
```

### STAGE 03: Other Modules

#### [impermanence](https://github.com/nix-community/impermanence)

```nix
##### flake.nix #####
{
  inputs = {
    impermanence.url = "github:nix-community/impermanence";
  };
}

##### nixos/configuration.nix #####
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  environment.persistence."/persistent" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/etc/ssh"
    ];
    files = [];
    users."philopence" = {
      directories = [
        "nix-configuration"
      ];
      files = [
        ".ssh/known_hosts"
      ];
    };
  };
}

##### nixos/hardware-configuration.nix #####
{
  fileSystems."/persistent" = {
    neededForBoot = true;
  };

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/disk/by-label/SYSTEM /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';
}
```

```sh
nix flake update

sudo nixos-rebuild switch --flake .#hostname

cp -r ./* ~/nix-configuration

reboot
```

#### [sops-nix](https://github.com/Mic92/sops-nix)

1. personal keys (`SOPS_AGE_KEY_FILE`)
2. host keys (`ssh-to-age`)
3. `.sops.yaml`
4. `secrets.yaml`

```nix
##### flake.nix #####
{
  inputs = {
    sops-nix.url = "github:Mic92/sops-nix";
  };
}

##### nixos/configuration.nix #####
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ../../extras/secrets.yaml;
    gnupg.sshKeyPaths = [];
    age.sshKeyPaths = ["/persistent/etc/ssh/ssh_host_ed25519_key"];
    secrets = {};
  };

  environment.variables = {
    SOPS_AGE_KEY_FILE = "/persistent/home/philopence/keys.txt";
  };
}
```

```sh
nix flake update

sudo nixos-rebuild switch --flake .#hostname

reboot
```

#### [nixos-hardware](https://github.com/NixOS/nixos-hardware)

```nix
##### flake.nix #####
{
  inputs = {
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };
}

##### nixos/configuration.nix #####
{
  imports = [
    ## https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
  ];
}
```

## Tips and Tricks

- [Neovim Default Palette](https://github.com/neovim/neovim/blob/master/src/nvim/highlight_group.c)
- Print SHA256: `nix store prefetch-file <url>`
- Print outpath: `nix eval <flake>#<package-name>`
- Prisma hate NixOS
  - https://github.com/prisma/prisma/pull/23672
  - https://github.com/prisma/prisma/issues/3026#issuecomment-927258138
  - https://github.com/VanCoding/nix-prisma-utils

## References

- [NixOS & Flakes Book](https://nixos-and-flakes.thiscute.world/)
- [Nix Starter Config](https://github.com/Misterio77/nix-starter-configs)
