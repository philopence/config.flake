{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.rofi;
in {
  options.features.rofi = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      extraConfig = {
        modi = "drun,window";
        show-icons = false;
        drun-display-format = "{name}";
        drun-match-fields = "name";
      };

      theme = let
        inherit (config.lib.formats.rasi) mkLiteral;
      in {
        "*" = {
          font = "Monospace 12";
          bg = mkLiteral config.palette.background;
          fg = mkLiteral config.palette.foreground;
          normal = mkLiteral config.palette.color7;
          active = mkLiteral config.palette.color4;
          border = mkLiteral config.palette.color4;
        };

        "window" = {
          width = mkLiteral "30%";
        };

        "mainbox" = {
          padding = mkLiteral "10";
          background-color = mkLiteral "@bg";
          children = map mkLiteral ["inputbar" "listview"];
          border = 2;
          border-color = mkLiteral "@border";
        };

        "inputbar" = {
          children = map mkLiteral ["entry"];
          # padding = mkLiteral "20";
          # background-image = mkLiteral "url(\"~/nix-configuration/extras/desktop.png\", width)";
          margin = mkLiteral "0 0 10 0";
        };

        "entry" = {
          horizontal-align = mkLiteral "0.5";
          text-color = mkLiteral "@fg";
          background-color = mkLiteral "@bg";
          # background-color = mkLiteral "transparent";
          padding = mkLiteral "10";
          border = mkLiteral "0 0 2 0";
          border-color = mkLiteral "@border";
        };

        "listview" = {
          padding = mkLiteral "10 0";
          spacing = mkLiteral "10";
          background-color = mkLiteral "@bg";
          lines = 7;
        };

        "element-text" = {
          text-color = mkLiteral "inherit";
          background-color = mkLiteral "inherit";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.5";
        };

        "element normal" = {
          text-color = mkLiteral "@normal";
          background-color = mkLiteral "@bg";
        };

        "element alternate" = {
          text-color = mkLiteral "@normal";
          background-color = mkLiteral "@bg";
        };

        "element selected" = {
          text-color = mkLiteral "@active";
          background-color = mkLiteral "@bg";
        };
      };
    };
  };
}
