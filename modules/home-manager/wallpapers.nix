{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  wallpapers = {
    default = {
      url = "https://w.wallhaven.cc/full/jx/wallhaven-jxyopy.png";
      sha256 = "sha256-tQTqSltVlQhlfONeyCy2lcSgla2agurO8zB5ghnVZSU=";
    };
    retro = {
      url = "https://w.wallhaven.cc/full/8o/wallhaven-8oky1j.jpg";
      sha256 = "sha256-4jRQQhny4k89LYF+IRSmUY8ueXl5kKd5w13BWE59qB4=";
    };
    balcony = {
      url = "https://w.wallhaven.cc/full/95/wallhaven-95j8kw.jpg";
      sha256 = "sha256-WNEmtD+T5vdJAILlagAv4xW4XT+7Z9mmIraOs3Ar5Ss=";
    };
    smoke = {
      url = "https://w.wallhaven.cc/full/9d/wallhaven-9dkeqd.png";
      sha256 = "sha256-VXbsxhPdHc9OgmD/Y1e2IiYIig9x/0+VUxqqAoSeTYQ=";
    };
    moonfly = {
      url = "https://w.wallhaven.cc/full/rr/wallhaven-rrll6m.png";
      sha256 = "sha256-cY43cVw5nOT6WR1Zd9dJC1+LEiTzIEhfRa4etEzSJJE=";
    };
    rise = {
      url = "https://w.wallhaven.cc/full/13/wallhaven-13zzg9.png";
      sha256 = "sha256-2fco21k25MytB6F/+SZ1UlSwGErmXPdiqZco6QVYUYU=";
    };
    cat = {
      url = "https://w.wallhaven.cc/full/o3/wallhaven-o3j1yl.jpg";
      sha256 = "sha256-z/a1v4wQ0MFil1oluwFnEluKRGV1x+yz4bRSmZWCJFY=";
    };
    pepe = {
      url = "https://w.wallhaven.cc/full/jx/wallhaven-jxyopy.png";
      sha256 = "sha256-tQTqSltVlQhlfONeyCy2lcSgla2agurO8zB5ghnVZSU=";
    };
    girl = {
      url = "https://w.wallhaven.cc/full/gj/wallhaven-gjyoq7.png";
      sha256 = "sha256-3vcKZ8x+58Ys5ZlcQMoW2lORILpSAmzrRwzCA1DljcU=";
    };
    music = {
      url = "https://w.wallhaven.cc/full/3z/wallhaven-3zp6o9.jpg";
      sha256 = "sha256-+4FNlHJ0OMdBlxZ+VgO1aH7aBzOgG3lImeM1Wa1FbzQ=";
    };
  };
  outputsWallpaper = lib.attrsets.attrByPath ["wallpaper"] "default" outputs;
  wallpaper = lib.attrsets.attrByPath [outputsWallpaper] wallpapers.default wallpapers;
in {
  imports = [];

  config = {
    home.file.".background-image".source = pkgs.fetchurl wallpaper;
  };
}
