{
  description = "Devshell for developing and building this config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [(_: super: {fennel-ls = super.callPackage ./nix/fennel-ls.nix {};})];
        };
      in
        with pkgs; {
          devShells.default = mkShell {
            buildInputs = [
              act
              fennel
              fennel-ls
              fnlfmt
              marksman
              nodePackages.cspell
              nodePackages.prettier
              nodejs
              stylua
              sumneko-lua-language-server
            ];
          };
        }
    );
}
