let
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) { };
in
{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    nativeBuildInputs = [ cmake pkg-config ];
    buildInputs = [
      awscli2
      unstable.aws-vault
      figlet
      lolcat
      python310
      python310Packages.pip
      python310Packages.setuptools
      #ansible_2_10 #uncommend if system wide not existing
      ugrep
      flux
      fluxcd
      ];
    shellHook = ''
        export PIP_PREFIX=$(pwd)/_build/pip_packages
        export PYTHONPATH="$PIP_PREFIX/${pkgs.python310.sitePackages}:$PYTHONPATH"
        export PATH="$PIP_PREFIX/bin:$PATH"
        unset SOURCE_DATE_EPOCH
        exec zsh
      '';  
    AWS_PAGER = "";
    AWS_VAULT_PASS_PREFIX = "aws-vault";
    AWS_VAULT_BACKEND = "pass";
}
