{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  palettes = {
    default = {
      foreground = "#e0e2ea";
      background = "#14161b";
      color0 = "#07080d";
      color1 = "#ffc0b9";
      color2 = "#b3f6c0";
      color3 = "#fce094";
      color4 = "#a6dbff";
      color5 = "#ffcaff";
      color6 = "#8cf8f7";
      color7 = "#9b9ea4";
      color8 = "#4f5258";
      color9 = "#ffc0b9";
      color10 = "#b3f6c0";
      color11 = "#fce094";
      color12 = "#a6dbff";
      color13 = "#ffcaff";
      color14 = "#8cf8f7";
      color15 = "#c4c6cd";
      color16 = "#FFA07A";
    };
    moonfly = {
      foreground = "#bdbdbd";
      background = "#080808";
      color0 = "#323437";
      color1 = "#ff5454";
      color2 = "#8cc85f";
      color3 = "#e3c78a";
      color4 = "#80a0ff";
      color5 = "#cf87e8";
      color6 = "#79dac8";
      color7 = "#c6c6c6";
      color8 = "#626262";
      color9 = "#ff5189";
      color10 = "#36c692";
      color11 = "#c6c684";
      color12 = "#74b2ff";
      color13 = "#ae81ff";
      color14 = "#85dc85";
      color15 = "#e4e4e4"; #b2ceee
      color16 = "#de935f";
    };
    tokyonight = {
      foreground = "#c8d3f5";
      background = "#222436";
      color0 = "#1b1d2b";
      color1 = "#ff757f";
      color2 = "#c3e88d";
      color3 = "#ffc777";
      color4 = "#82aaff";
      color5 = "#c099ff";
      color6 = "#86e1fc";
      color7 = "#565f89";
      color8 = "#2d3f76";
      color9 = "#ff757f";
      color10 = "#c3e88d";
      color11 = "#ffc777";
      color12 = "#82aaff";
      color13 = "#c099ff";
      color14 = "#86e1fc";
      color15 = "#c8d3f5";
      color16 = "#ff966c"; #fca7ea
    };
    catppuccin = {
      foreground = "#cdd6f4";
      background = "#1e1e2e";
      color0 = "#181825";
      color1 = "#f38ba8";
      color2 = "#a6e3a1";
      color3 = "#f9e2af";
      color4 = "#89b4fa";
      color5 = "#f5c2e7";
      color6 = "#94e2d5";
      color7 = "#6c7086";
      color8 = "#45475a";
      color9 = "#f38ba8";
      color10 = "#a6e3a1";
      color11 = "#f9e2af";
      color12 = "#89b4fa";
      color13 = "#f5c2e7";
      color14 = "#94e2d5";
      color15 = "#bac2de";
      color16 = "#fab387"; #f5e0dc #cba6f7
    };
    rose-pine = {
      foreground = "#e0def4";
      background = "#191724";
      color0 = "#1f1d2e";
      color1 = "#eb6f92";
      color2 = "#31748f";
      color3 = "#f6c177";
      color4 = "#9ccfd8";
      color5 = "#c4a7e7";
      color6 = "#ebbcba";
      color7 = "#908caa";
      color8 = "#6e6a86";
      color9 = "#eb6f92";
      color10 = "#31748f";
      color11 = "#f6c177";
      color12 = "#9ccfd8";
      color13 = "#c4a7e7";
      color14 = "#ebbcba";
      color15 = "#e0def4";
      color16 = "#8ea788";
    };
    gruvbox = {
      foreground = "#EBDBB2";
      background = "#282828";
      color0 = "#1D2021";
      color1 = "#CC241D";
      color2 = "#98971A";
      color3 = "#D79921";
      color4 = "#458588";
      color5 = "#B16286";
      color6 = "#689D6A";
      color7 = "#928374";
      color8 = "#504945";
      color9 = "#FB4934";
      color10 = "#B8BB26";
      color11 = "#FABD2F";
      color12 = "#83A598";
      color13 = "#D3869B";
      color14 = "#8EC07C";
      color15 = "#EBDBB2";
      color16 = "#FE9019"; #D65D0E
    };
    kanagawa = {
      foreground = "#DCD7BA";
      background = "#1F1F28";
      color0 = "#16161D";
      color1 = "#C34043";
      color2 = "#76946A";
      color3 = "#C0A36E";
      color4 = "#7E9CD8";
      color5 = "#957FB8";
      color6 = "#6A9589";
      color7 = "#727169";
      color8 = "#363646";
      color9 = "#E82424";
      color10 = "#98BB6C";
      color11 = "#E6C384";
      color12 = "#7FB4CA";
      color13 = "#938AA9";
      color14 = "#7AA89F";
      color15 = "#C8C093";
      color16 = "#D27E99"; #FFA066 #FF5D62
    };
    everforest = {
      foreground = "#d3c6aa";
      background = "#2d353b";
      color0 = "#232A2E";
      color1 = "#e67e80";
      color2 = "#a7c080";
      color3 = "#dbbc7f";
      color4 = "#7fbbb3";
      color5 = "#d699b6";
      color6 = "#83c092";
      color7 = "#859289";
      color8 = "#4F585E";
      color9 = "#e67e80";
      color10 = "#a7c080";
      color11 = "#dbbc7f";
      color12 = "#7fbbb3";
      color13 = "#d699b6";
      color14 = "#83c092";
      color15 = "#9DA9A0";
      color16 = "#E69875";
    };
    nightfox = {
      foreground = "#cdcecf";
      background = "#192330";
      color0 = "#131a24";
      color1 = "#c94f6d";
      color2 = "#81b29a";
      color3 = "#dbc074";
      color4 = "#719cd6";
      color5 = "#9d79d6";
      color6 = "#63cdcf";
      color7 = "#738091";
      color8 = "#39506d";
      color9 = "#d16983";
      color10 = "#8ebaa4";
      color11 = "#dbbc7f";
      color12 = "#86abdc";
      color13 = "#baa1e2";
      color14 = "#7ad5d6";
      color15 = "#e4e4e5";
      color16 = "#f4a261"; #d67ad2
    };
  };
  outputsPalette = lib.attrsets.attrByPath ["palette"] "default" outputs;
  palette = lib.attrsets.attrByPath [outputsPalette] palettes.default palettes;
in {
  imports = [];

  options.palette = mkOption {
    type = types.attrs;
  };

  config = {
    inherit palette;
  };
}
