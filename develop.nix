{ pkgs }: with pkgs; let

  ghcCharged =  haskellPackages.ghcWithHoogle (p: with p; [
                  haskell-language-server
                  ghcid
                ]);
  ghcid-bin = haskellPackages.ghcid.bin;

in mkShell {
  buildInputs =  haskellPackages.kw-scientific.env.nativeBuildInputs ++
                 [ ghcCharged
                   ghcid-bin
                   cabal-install
                 ];
  nativeBuildInputs = with pkgs; [ pkgconfig ];

}
