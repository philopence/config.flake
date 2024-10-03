{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.impermanence;
in {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];
  options.features.impermanence = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    environment.persistence."/persistent" = {
      enable = true;
      hideMounts = true;
      directories = [
        "/etc/ssh"
        "/var/lib/docker"
      ];
      files = [];
      users."philopence" = {
        directories = [
          ".ssh"
          ".cache"
          ".config"
          ".local"
          "Desktop"
          "Documents"
          "Downloads"
          "Music"
          "Pictures"
          "Public"
          "Templates"
          "Videos"
          ##
          ".fceux"
        ];
        files = [];
      };
    };
  };
}
