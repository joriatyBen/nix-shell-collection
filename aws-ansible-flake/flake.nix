{
  description = "Belectric flake for dev environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }: 
  let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs {
        inherit system;
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
      };
    in pkgs.mkShell {
      packages = with pkgs; [
        awscli2
        pkgs-unstable.aws-vault
        figlet
        lolcat
        python310
        python310Packages.pip
        python310Packages.setuptools
        ugrep
        flux
        fluxcd
        jsonnet
      ];
      shellHook = ''
        export PIP_PREFIX=$(pwd)/_build/pip_packages
        export PYTHONPATH="$PIP_PREFIX/${pkgs.python310.sitePackages}:$PYTHONPATH"
        export PATH="$PIP_PREFIX/bin:$PATH"
        unset SOURCE_DATE_EPOCH
        exec zsh
      '';
      # aws vault env vars
      AWS_PAGER = "";
      AWS_VAULT_PASS_PREFIX = "aws-vault";
      AWS_VAULT_BACKEND = "pass";
    };
  };
}

