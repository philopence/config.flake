{
  outputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.neovim;
in {
  options.features.neovim = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      # package = pkgs.neovim;
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraWrapperArgs = [
        "--suffix"
        "PALETTE"
        ":"
        "${outputs.palette}"
        # "--suffix"
        # "LIBRARY_PATH"
        # ":"
        # "${makeLibraryPath [ pkgs.glibc pkgs.libgcc pkgs.icu ]}"
      ];
      extraPackages = with pkgs; [
        gcc
        gnumake
        unzip
        luajitPackages.luarocks
        lua
        nodePackages.nodejs
        ripgrep
        fd
        jq
        fzf
        xclip
        prettierd
        eslint_d
        stylua
        gopls
        tailwindcss-language-server
        vscode-langservers-extracted
        lua-language-server
        clang-tools
        vue-language-server
      ];
    };

    xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${outputs.flakePath}/extras/nvim";
  };
}
