let
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) { };
in
{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
  
  nativeBuildInputs = with pkgs; [ 
    pkg-config 
    llvm 
    clang 
    unstable.rustc 
    unstable.cargo
    libelf
  ];
  
  buildInputs = with pkgs; [
  cmake
  udev
  openssl
  pkg-config
  rustfmt
  unstable.rustup #execute: rustup install stable
  ];

  LIBCLANG_PATH = "${llvmPackages.libclang.lib}/lib";
  PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
#  shellHook = 
#  ''
#    zsh
#  '';
}


