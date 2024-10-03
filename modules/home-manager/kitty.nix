{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.kitty;
in {
  options.features.kitty = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      keybindings = {
        ## TUI tools
        "ctrl+shift+g" = "launch --cwd=current --type=os-window --os-window-class=lazygit lazygit";
        ## Font Sizes
        "ctrl+shift+plus" = "change_font_size all +1.0";
        "ctrl+shift+minus" = "change_font_size all -1.0";
        ## WINDOW
        "ctrl+shift+up" = "previous_window";
        "ctrl+shift+down" = "next_window";
        "alt+shift+up" = "move_window_backward";
        "alt+shift+down" = "move_window_forward";
        "ctrl+shift+x" = "launch --cwd=current --location=hsplit";
        "ctrl+shift+v" = "launch --cwd=current --location=vsplit";
        "super+c" = "copy_to_clipboard";
        "super+v" = "paste_from_clipboard";
        "super+s" = "paste_from_selection";
        "ctrl+shift+space" = "toggle_layout stack";
        "ctrl+shift+w" = "focus_visible_window";
        "ctrl+alt+r" = "start_resizing_window";
        ## TAB
        # "ctrl+shift+t" = "combine : new_tab_with_cwd : set_tab_title ' '";
        "ctrl+shift+tab" = "select_tab";
        "ctrl+shift+left" = "previous_tab";
        "ctrl+shift+right" = "next_tab";
        "alt+shift+left" = "move_tab_backward";
        "alt+shift+right" = "move_tab_forward";
        "ctrl+shift+t" = "new_tab_with_cwd";
        "ctrl+shift+r" = "set_tab_title";
      };
      settings = {
        enable_audio_bell = "no";
        enabled_layouts = "splits,stack";
        # v0.36.3
        transparent_background_colors = "#2e2e2e@0.67 #323437@0.67 #626262@0.67";
        background_opacity = "0.93";
        window_padding_width = 2;
        window_border_width = 1;
        cursor_stop_blinking_after = 0;
        font_size = "10.0";
        "modify_font cell_height" = "110%";
        # "modify_font cell_width" = "1";

        # font_family = "family='Cascadia Code' features='+calt +ss01 +ss02 +ss03 +ss19 +ss20'";
        # font_family = "family='JetBrains Mono'";
        # font_family = "family='Iosevka Extended'";
        # font_family = "family=CommitMono";
        # font_family = "family='Hermit'";
        # font_family = "family='Departure Mono'";
        # bold_font = "auto";
        # italic_font = "auto";
        # bold_italic_font = "auto";
        font_family = "family=Iosevka style=Extended";
        bold_font = "family=Iosevka style='Bold Extended'";
        italic_font = "family=Iosevka style='Extended Italic'";
        bold_italic_font = "family=Iosevka style='Bold Extended Italic'";

        foreground = config.palette.foreground;
        background = config.palette.background;
        selection_foreground = "none";
        selection_background = config.palette.color0;
        cursor = "none";
        url_color = config.palette.color5;
        active_border_color = config.palette.color4;
        inactive_border_color = config.palette.color4;
        active_tab_foreground = config.palette.background;
        active_tab_background = config.palette.color4;
        active_tab_font_style = "bold";
        inactive_tab_foreground = config.palette.color8;
        inactive_tab_background = config.palette.background;
        color0 = config.palette.color0;
        color1 = config.palette.color1;
        color2 = config.palette.color2;
        color3 = config.palette.color3;
        color4 = config.palette.color4;
        color5 = config.palette.color5;
        color6 = config.palette.color6;
        color7 = config.palette.color7;
        color8 = config.palette.color8;
        color9 = config.palette.color9;
        color10 = config.palette.color10;
        color11 = config.palette.color11;
        color12 = config.palette.color12;
        color13 = config.palette.color13;
        color14 = config.palette.color14;
        color15 = config.palette.color15;
      };
    };
  };
}
