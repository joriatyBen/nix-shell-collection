with import <nixpkgs> {};
stdenv.mkDerivation rec {
  name = "campudus";
  env = buildEnv { name = name; paths = buildInputs; };
  buildInputs = [
    nodejs-19_x
    yarn
    nodePackages."@nestjs/cli"
    nodePackages.typescript
    nodePackages.prettier
    nodePackages.eslint
  ];

  shellHook =
  ''  
    zsh
  '';
}

