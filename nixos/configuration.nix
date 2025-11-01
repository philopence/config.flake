{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports =
    [
      inputs.nixos-hardware.nixosModules.common-cpu-intel
      inputs.nixos-hardware.nixosModules.common-pc-ssd
      inputs.nixos-hardware.nixosModules.common-pc-laptop
      inputs.home-manager.nixosModules.home-manager
      ./hardware-configuration.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  features.fonts.enable = true;
  features.xserver.enable = true;
  features.proxy.enable = true;
  features.impermanence.enable = true;
  features.sops.enable = true;

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      nix-path = config.nix.nixPath;
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    # channel.enable = false;
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  nixpkgs = {
    overlays = [] ++ (builtins.attrValues outputs.overlays);
    config = {
      allowUnfree = true;
    };
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    useGlobalPkgs = true;
    users = {
      "philopence" = import ../home-manager/home.nix;
    };
  };

  programs.fish.enable = true;
  users.mutableUsers = false;
  # users.defaultUserShell = pkgs.fish;
  users.users = {
    "philopence" = {
      # NOTE mkpasswd -m SHA-512 -s "<PASSWORD>"
      initialHashedPassword = "$6$wR4jAw0vgswTtVDF$M40LztVxPcSl63e7ABbWl4mBQY9EGn/U9qdg8DTiRdaglhnTFK5m0aoiNoIqDzqdNSU1mg0mBvx6s6zH250Ie0";
      shell = pkgs.fish;
      isNormalUser = true;
      extraGroups = ["wheel"];
      openssh.authorizedKeys.keys = [];
      packages = with pkgs; [];
    };
  };

  programs.nh.enable = true;
  programs.nh.flake = outputs.flakePath;
  programs.nh.clean.enable = true;
  programs.nh.clean.extraArgs = "--keep 5 --keep-since 7d";

  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";

  networking.hostName = "nixos";

  # NOTE wpa_passphrase SSID PASSPHRASE
  networking.wireless.enable = true;
  networking.wireless.networks."CMCC-nUgj" = {
    # pskRaw = "65817bfc67e58a05af60e6904800adea398ddb97a38922b16e223abcdb0c3f4f";
    psk = "0123456789";
  };

  # TODO work with sing-box
  networking.firewall.enable = false;

  environment.localBinInPath = true;

  ## Can't work with wireless module
  # services.create_ap = {
  #   enable = true;
  #   settings = {
  #     INTERNET_IFACE = "enp3s0";
  #     WIFI_IFACE = "wlp2s0";
  #     PASSPHRASE = "0123456789";
  #     SSID = "NixOS Hotspot";
  #     # PERSISTENT_DAEMON = true;
  #   };
  # };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  hardware.graphics.enable = true;

  hardware.keyboard.qmk.enable = true;

  services.udisks2.enable = true;

  programs.dconf.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelModules = ["tcp_bbr"];
  boot.kernel.sysctl = {
    "net.ipv4.tcp_congestion_control" = "bbr";
  };

  programs.nix-ld.enable = true;

  programs.localsend.enable = true;

  virtualisation.docker.enable = true;

  system.stateVersion = outputs.stateVersion;
}
