{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.tmpPicom;
in {
  imports = [];

  options.features.tmpPicom = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [picom];
    xdg.configFile."picom/picom.conf".source = ./picom.conf;

    systemd.user.services.picom = {
      Unit = {
        Description = "Picom X11 compositor";
        After = ["graphical-session-pre.target"];
        PartOf = ["graphical-session.target"];
      };

      Install = {WantedBy = ["graphical-session.target"];};

      Service = {
        ExecStart = concatStringsSep " " [
          "${getExe pkgs.picom}"
          "--config ${config.xdg.configFile."picom/picom.conf".source}"
        ];
        Restart = "always";
        RestartSec = 3;
      };
    };
  };
}
