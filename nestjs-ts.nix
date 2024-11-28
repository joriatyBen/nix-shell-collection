{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    buildInputs = [
      nodejs_20
      yarn
      nodePackages."@nestjs/cli"
      nodePackages.typescript
      nodePackages.prettier
      nodePackages.eslint
      bun
    ];

    shellHook = ''
        exec zsh
    '';  
}

