{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.fonts;
in {
  options.features.fonts = {
    enable = mkEnableOption "TEMPLATE";
  };

  config = mkIf cfg.enable {
    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
        jost
        lxgw-neoxihei
        lxgw-wenkai
        ibm-plex
        cascadia-code
        jetbrains-mono
        iosevka
        departure-mono
        commit-mono
        mononoki
        ubuntu-sans-mono
        monaspace
        recursive
        victor-mono
        fira-code
        hermit
        # https://github.com/subframe7536/maple-font/issues/141
        # maple-mono-SC-NF
        # sarasa-gothic
      ];
      fontconfig = {
        defaultFonts = {
          serif = ["Jost*" "LXGW WenKai" "LXGW Neo XiHei" "Noto Color Emoji"];
          sansSerif = ["Jost*" "LXGW Neo XiHei" "LXGW WenKai" "Noto Color Emoji"];
          monospace = ["Iosevka" "Symbols Nerd Font Mono" "LXGW WenKai" "LXGW Neo XiHei" "Noto Color Emoji"];
        };
        localConf = ''
          <?xml version="1.0"?>
          <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
          <fontconfig>
            <match target="pattern">
              <test qual="any" name="family" compare="eq"><string>Arial</string></test>
              <edit name="family" mode="assign" binding="same"><string>sans-serif</string></edit>
            </match>
            <match target="pattern">
              <test qual="any" name="family" compare="eq"><string>Helvetica</string></test>
              <edit name="family" mode="assign" binding="same"><string>sans-serif</string></edit>
            </match>
            <match target="pattern">
              <test qual="any" name="family" compare="eq"><string>Noto Sans</string></test>
              <edit name="family" mode="assign" binding="same"><string>sans-serif</string></edit>
            </match>
          </fontconfig>
        '';
      };
    };
  };
}
