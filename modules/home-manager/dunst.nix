{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.dunst;

  foreground = config.palette.foreground;
  background = config.palette.background;
  frame_color = config.palette.color4;
in {
  options.features.dunst = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          offset = "15x15";
          frame_width = 2;
          font = "Monospace 10";
          inherit frame_color;
        };
        urgency_low = {
          timeout = 3;
          inherit foreground background;
        };
        urgency_normal = {
          timeout = 5;
          inherit foreground background;
        };
        urgency_critical = {
          timeout = 0;
          inherit foreground background;
        };
      };
    };
  };
}
