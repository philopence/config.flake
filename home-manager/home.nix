{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [] ++ (builtins.attrValues outputs.homeManagerModules);

  features.dkwm.enable = true;
  features.rime.enable = true;
  features.rofi.enable = true;
  # TODO https://github.com/nix-community/home-manager/issues/5744
  # features.picom.enable = true;
  features.tmpPicom.enable = true;
  features.dunst.enable = true;
  features.kitty.enable = true;
  features.neovim.enable = true;
  features.mpd.enable = true;

  home = {
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "24.05";
    username = "philopence";
    homeDirectory = "/home/${config.home.username}";
    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 20;
      gtk.enable = true;
      x11.enable = true;
    };
    sessionVariables = {};
    sessionPath = [
      "$XDG_DATA_HOME/npm/bin"
    ];
    file = {
      # registry = https://registry.npmmirror.com
      ".npmrc".text = ''
        prefix = ''${XDG_DATA_HOME}/npm
        cache = ''${XDG_CACHE_HOME}/npm
      '';
    };
    packages = with pkgs; [
      gcc
      clang-tools
      gnumake
      nodePackages.nodejs
      go
      python3
      unzip
      httpie
      brave
      keepassxc
      mongosh
      fceux
    ];
  };

  gtk = {
    enable = true;
    font = {
      name = "Sans";
      size = 10;
    };
    theme = {
      name = "Adwaita-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  xsession.enable = true;

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  xdg.desktopEntries = {
    fceux = {
      name = "Fceux";
      exec = "${pkgs.fceux}/bin/fceux";
    };
  };

  services.udiskie.enable = true;

  programs.fish = {
    enable = true;
    functions = {
      fish_greeting = "";
    };
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
        HostName ssh.github.com
        User git
        Port 443
    '';
  };

  programs.zoxide.enable = true;
  programs.ripgrep.enable = true;
  programs.bat.enable = true;
  programs.fzf.enable = true;

  ## TODO ISSUE: https://github.com/nix-community/home-manager/issues/4807
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      line_break = {
        disabled = true;
      };
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      gui.theme = {
        selectedLineBgColor = [config.palette.color8];
      };
    };
  };

  programs.eza = {
    enable = true;
    git = true;
    icons = true;
  };

  programs.btop = {
    enable = true;
    settings = {
      theme_background = false;
    };
  };

  programs.git = {
    enable = true;
    userName = "philopence";
    userEmail = "philopence@gmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
}
