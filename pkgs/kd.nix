{
  lib,
  stdenv,
  fetchurl,
}:
  stdenv.mkDerivation {
    pname = "kd";
    version = "0.0.11";
    src = fetchurl {
      url = "https://github.com/Karmenzind/kd/releases/download/v0.0.11/kd_linux_amd64";
      sha256 = "sha256-JLBGuOlEjfufpatFt1kpPe2OyKM4zipxiVbzfBKf7sE=";
    };
    phases = [ "installPhase" ];

    installPhase = ''
      mkdir -p $out/bin
      install -m755 $src $out/bin/kd
    '';
  }
