{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.rime;
in {
  options.features.rime = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [fcitx5-rime];
    };
    xdg.dataFile = {
      "fcitx5/rime/zhwiki.dict.yaml".source = pkgs.fetchurl {
        url = "https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.5/zhwiki-20240509.dict.yaml";
        sha256 = "sha256-lihR5q+brhaweHD1ggtAzvFMqQ2Rt+REeOH4K8V20gI=";
      };

      "fcitx5/rime/moegirl.dict.yaml".source = pkgs.fetchurl {
        url = "https://github.com/outloudvi/mw2fcitx/releases/download/20240609/moegirl.dict.yaml";
        sha256 = "sha256-XC+hsILC58VVKlmUbaVw0IAqggterR4h5igjM3PQWO8=";
      };

      "fcitx5/rime/default.custom.yaml".text = ''
        patch:
          ascii_composer:
            switch_key:
              Shift_L: commit_code
              Shift_R: noop
              # commit_code commit_text
          key_binder:
            bindings:
              - {accept: Left, send: Page_Up, when: has_menu}
              - {accept: Right, send: Page_Down, when: has_menu}
              - {accept: Release+Escape, toggle: ascii_mode, when: always}
      '';

      "fcitx5/rime/luna_pinyin.custom.yaml".text = ''
        patch:
          "switches/@0/reset": 1
          "switches/@2/reset": 1
          "recognizer/patterns/reverse_lookup":
          "translator/dictionary": extended
          "punctuator/half_shape/=":
            "'": {pair: ["「", "」"]}
            "\"": {pair: ["『", "』"]}
      '';

      "fcitx5/rime/extended.dict.yaml".text = ''
        ---
        name: extended
        version: "0.0.1"
        sort: by_weight
        use_preset_vocabulary: true
        import_tables:
          - luna_pinyin
          - zhwiki
          - moegirl
        ...
      '';
    };
  };
}
