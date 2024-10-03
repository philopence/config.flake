{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.TEMPLATE;
in {
  imports = [];

  options.features.TEMPLATE = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {};
}
