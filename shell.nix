# Shell for bootstrapping flake-enabled nix and home-manager
# You can enter it through 'nix develop' or (legacy) 'nix-shell'
pkgs: {
  default = pkgs.mkShell {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [nix home-manager git];
  };
  secret = pkgs.mkShell {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [git sops age];
    shellHook = ''
      exec fish
    '';
  };
  r = pkgs.mkShell {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [(rWrapper.override {packages = with rPackages; [ggplot2];})];
  };
  py = pkgs.mkShell {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    packages = [
      (pkgs.python3.withPackages (python-pkgs: [
        python-pkgs.scikit-learn
      ]))
    ];
  };
  ## https://github.com/prisma/prisma/pull/23672
  prisma = pkgs.mkShell {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [nodePackages.prisma];
    shellHook = with pkgs; ''
      export PRISMA_QUERY_ENGINE_BINARY="${prisma-engines}/bin/query-engine"
      export PRISMA_QUERY_ENGINE_LIBRARY="${prisma-engines}/lib/libquery_engine.node"
      export PRISMA_SCHEMA_ENGINE_BINARY="${prisma-engines}/bin/schema-engine";
      export PRISMA_FMT_BINARY="${prisma-engines}/bin/prisma-fmt"
    '';
  };
}
