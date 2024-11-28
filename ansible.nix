let
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) { };
in
{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    buildInputs = [
      python312
      python312Packages.pip
      python312Packages.setuptools
      unstable.ansible_2_15
      ];
    shellHook = ''
        export PIP_PREFIX=$(pwd)/_build/pip_packages
        export PYTHONPATH="$PIP_PREFIX/${pkgs.python312.sitePackages}:$PYTHONPATH"
        export PATH="$PIP_PREFIX/bin:$PATH"
        unset SOURCE_DATE_EPOCH
        exec zsh
      '';  
}
