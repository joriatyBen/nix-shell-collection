 {
  description = "python venv and tools for BC25";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";    
    nixpkgs-predecessor.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, nixpkgs-predecessor, flake-utils }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pname = "bc_25";
        pkgs = nixpkgs.legacyPackages."${system}";
        pkgs-predecessor = nixpkgs-predecessor.legacyPackages."${system}";
        venvDir = ".venv";
      in
        rec {
          inherit pname;

          devShell = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              python312Packages.python
              python312Packages.python-lsp-server
              python312Packages.autopep8
              poetry
              uv # better faster pip
              k9s
              kubectl
              krew
              kubelogin
              pkgs-predecessor.abctl
            ];
            
            shellHook = ''
                export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib.outPath}/lib:$LD_LIBRARY_PATH";
                export PATH="$HOME/.krew/bin:$PATH" 

                if [ -d "${venvDir}" ]; then
                  echo "Skipping venv creation, '${venvDir}' already exists"
                else
                  echo "Creating new venv environment in path: '${venvDir}'"
                  python -m venv "${venvDir}"
                fi

                source "${venvDir}/bin/activate"

                exec zsh
              '';
          };
        }
    );
} 


