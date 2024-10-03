{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.dkwm;
in {
  options.features.dkwm = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [brightnessctl maim];
    xdg.configFile."dk/dkrc".source = pkgs.writeShellScript "dkrc" ''
      ## NOTE dkcmd: unable to get socket path from environment: Success
      pgrep -x sxhkd > /dev/null || ${pkgs.sxhkd}/bin/sxhkd -c "$HOME/.config/dk/sxhkdrc" &
      pgrep -f "kitty --class scratchpad" || kitty --class scratchpad &
      ${pkgs.feh}/bin/feh --no-fehbg --bg-fill $HOME/.background-image &

      xset r rate 200 50

      dkcmd set numws=5
      dkcmd set ws=_ apply layout=tile master=1 stack=5 gap=5 msplit=0.5 ssplit=0.5
      dkcmd set ws=2 gap=0
      dkcmd set focus_open=true focus_urgent=true focus_mouse=false
      dkcmd set tile_tohead=false tile_hints=true
      dkcmd set win_minwh=50 win_minxy=10
      dkcmd set smart_gap=false smart_border=false
      dkcmd set mouse mod=super move=button1 resize=button3
      dkcmd set border width=0 outer_width=0 colour focus=${config.palette.color4} urgent=${config.palette.color3} unfocus=${config.palette.color8} outer_focus=${config.palette.background} outer_urgent=${config.palette.background} outer_unfocus=${config.palette.background}

      dkcmd rule class="^scratchpad$" scratch=true float=true x=center y=0 w=600 h=400
      dkcmd rule class='^(Chromium-browser|Brave-browser)$' ws=2
      dkcmd rule class='^btop$' float=true x=center y=center w=1280 h=720
      dkcmd rule class='^yazi$' float=true x=center y=center w=1280 h=720
      dkcmd rule class='^lazygit$' float=true x=center y=center w=1280 h=720
      dkcmd rule apply '*'
      # dkcmd rule remove '*'

      exit 0
    '';

    xdg.configFile."dk/sxhkdrc".text = ''
      ## APPLICATION
      super + Escape
        pkill -USR1 -x sxhkd
      super + Return
        kitty -o allow_remote_control=yes
      super + space
        rofi -show drun
      super + Tab
        rofi -show window
      super + b
        brave
      super + {_,shift + }p
        maim -o {-s ,_}~/Pictures/screenshot_$(date +%s).png

      ## SYSTEM
      {XF86MonBrightnessDown,XF86MonBrightnessUp}
        brightnessctl set {5%-,5%+}
      {XF86AudioLowerVolume,XF86AudioRaiseVolume}
        wpctl set-volume @DEFAULT_AUDIO_SINK@ {3%-,3%+}
      XF86AudioMute
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

      ## DKWM
      super + shift + r
        $HOME/.config/dk/dkrc
      super + {Down,Up}
        dkcmd win focus {next,prev}
      super + shift + {Down,Up}
        dkcmd win mvstack {down,up}
      super + {_,shift + }{Left,Right}
        dkcmd ws {view,follow} {prev,next}
      super + w
        dkcmd win kill
      super + shift + s
        dkcmd win swap
      super + shift + c
        dkcmd win cycle
      super + f
        dkcmd win float
      super + u
        dkcmd win scratchpad scratch
      super + ctrl + {Left,Down,Up,Right}
        dkcmd win resize {w=-10,h=-10,h=+10,w=+10}
      super + alt + {Left,Down,Up,Right}
        dkcmd win resize {x=-10,y=+10,y=-10,x=+10}
      super + alt + Return
        dkcmd win resize x=center y=center; dkcmd win resize y=-1
    '';
  };
}
