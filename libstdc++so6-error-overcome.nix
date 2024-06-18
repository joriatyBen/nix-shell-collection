let
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) { };
in
{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    nativeBuildInputs = [ stdenv.cc.cc.lib ];
    buildInputs = [
      unstable.yarn
      ];
    shellHook = ''
        export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [
          pkgs.stdenv.cc.cc
        ]}
        exec zsh
      '';  
}

