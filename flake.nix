{
  description = "kw-scientific";

  inputs = {

    haedosa.url = "github:haedosa/flakes";
    nixpkgs.follows = "haedosa/nixpkgs";
    flake-utils.follows = "haedosa/flake-utils";

  };

  outputs =
    inputs@{ self, nixpkgs, flake-utils, ... }:
    {
      overlay = nixpkgs.lib.composeManyExtensions
        [
        ];
    } // flake-utils.lib.eachDefaultSystem (system:

      let
        pkgs = import nixpkgs {
          inherit system;
          config = {};
          overlays = [ self.overlay ];
        };

      in rec {
        defaultPackage = pkgs.haskellPackages.callPackage ./scientific.nix {};
        devShell = import ./develop.nix { inherit pkgs; };

        apps = let
          ghcEnv = pkgs.haskellPackages.ghcWithPackages (p: [ p.kw-scientific ]);
        in {
          ghci = {
            type = "app";
            program = "${ghcEnv}/bin/ghci";
          };
        };
        defaultApp = apps.ghci;
      }
    );

}
