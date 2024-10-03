{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.sops;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  options.features.sops = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      SOPS_AGE_KEY_FILE = "/persistent/home/philopence/keys.txt";
    };

    sops = {
      defaultSopsFile = ../../extras/secrets.yaml;
      gnupg.sshKeyPaths = [];
      age.sshKeyPaths = ["/persistent/etc/ssh/ssh_host_ed25519_key"];
      secrets = {
        "proxy/password".owner = "philopence";
        "proxy/us".owner = "philopence";
        "proxy/jp".owner = "philopence";
        "proxy/hk".owner = "philopence";
      };
    };
  };
}
