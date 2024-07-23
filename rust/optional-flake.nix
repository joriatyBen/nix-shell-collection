{
  description = "rust-az-demo";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay }: 
    flake-utils.lib.eachDefaultSystem (system: 
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ rust-overlay.overlays.default ];
        };
        toolchain = pkgs.rust-bin.fromRustupToolchainFile ./toolchain.toml;
      in {
        devShells.default = with pkgs; mkShell {
          name = "rust-default";

          packages = [
            rustc
            llvmPackages.bintools
            toolchain
            openssl
          ];
          
          PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
          LIBCLANG_PATH = pkgs.lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];
          PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1;
          
          #CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER = "gcc";


          shellHook = ''
            exec zsh
          '';

        };
      }
    );
}
