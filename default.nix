let
  pkgs = import <nixpkgs> { };
in
pkgs.stdenv.mkDerivation rec {
  pname = "watcher";
  version = "0.2";

  src = ./.;

  nativeBuildInputs = [ pkgs.makeWrapper ];

  buildInputs = with pkgs; [
    bash
    coreutils
    inotify-tools
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp watcher.sh $out/bin/watcher
  '';

  postFixup = ''
    wrapProgram $out/bin/watcher --prefix PATH : ${pkgs.lib.makeBinPath buildInputs}
  '';
}
