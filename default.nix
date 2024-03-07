let
  pkgs = import <nixpkgs> { };
in
pkgs.stdenv.mkDerivation {
  pname = "watcher";
  version = "0.1";

  src = ./.;

  buildInpits = with pkgs; [
    inotify-tools
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp watcher.sh $out/bin/watcher
  '';
}
