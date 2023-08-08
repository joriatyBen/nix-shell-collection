let
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) { };
in
{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
  nativeBuildInputs = with pkgs; [
    awscli2
    unstable.aws-vault
    #aws-vault
  ];
  shellHook = "zsh";
  AWS_PAGER = ""; 
  AWS_VAULT_PASS_PREFIX = "aws-vault";
  AWS_VAULT_BACKEND = "pass";
  #AWS_VAULT_PASS_PASSWORD_STORE_DIR = "$HOME/.password-store/aws-vault";
}
