{
  description = "Ansible flake for dev environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }: 
  let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs {
        inherit system;
      };
    in pkgs.mkShell {
      packages = with pkgs; [
        python312
        python312Packages.pip
        python312Packages.setuptools
        ansible_2_16
      ];
      shellHook = ''
        export PIP_PREFIX=$(pwd)/_build/pip_packages
        export PYTHONPATH="$PIP_PREFIX/${pkgs.python312.sitePackages}:$PYTHONPATH"
        export PATH="$PIP_PREFIX/bin:$PATH"
        unset SOURCE_DATE_EPOCH
        exec zsh
      '';
    };
  };
}

