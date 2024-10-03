# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;
  rime = import ./rime.nix;
  rofi = import ./rofi.nix;
  dunst = import ./dunst.nix;
  picom = import ./picom.nix;
  tmpPicom = import ./tmp-picom;
  kitty = import ./kitty.nix;
  neovim = import ./neovim.nix;
  dkwm = import ./dkwm.nix;
  mpd = import ./mpd.nix;
  palettes = import ./palettes.nix;
  wallpapers = import ./wallpapers.nix;
}
