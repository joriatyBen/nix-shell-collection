{
  description = "NestJs flake for dev environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
  };

  outputs = { self, nixpkgs, ... }: 
  let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs {
        inherit system;
      };
    in with pkgs; mkShell {
      packages = [
        nodejs_20
        yarn
        nodePackages."@nestjs/cli"
        nodePackages.typescript
        nodePackages.prettier
        nodePackages.eslint
      ];
      shellHook = ''
        zsh
      '';
    };
  };
}

