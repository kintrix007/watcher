let
  pkgs = import <nixpkgs> { };
in
pkgs.stdenv.mkDerivation rec {
  pname = "watcher";
  version = "0.1";

  src = ./.;

  nativeBuildInputs = [ pkgs.makeWrapper ];

  buildInputs = with pkgs; [
    inotify-tools
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp watcher.sh $out/bin/watcher
  '';

  postFixup =
    let
      runtimePath = pkgs.lib.makeBinPath buildInputs;
    in
    ''
      sed -i '2 i export PATH="${runtimePath}:$PATH"' $out/bin/watcher
    '';
}
