{
  description = "Devshell for developing and building this config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [(self: super: {fennel-language-server = super.callPackage ./nix/fennel-language-server.nix {};})];
        };
      in
        with pkgs; {
          devShells.default = mkShell {
            buildInputs = [
              act
              fennel
              fennel-language-server
              fnlfmt
              marksman
              nodePackages.cspell
              nodePackages.prettier
              nodejs
              stylua
              sumneko-lua-language-server
              neovim
            ];
          };
        }
    );
}
