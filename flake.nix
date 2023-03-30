{
  description = "Devshell for developing and building this config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.url = "github:nixos/nixpkgs?rev=fad51abd42ca17a60fc1d4cb9382e2d79ae31836";
    };
  };

  outputs = {
    self,
    nixpkgs,
    neovim-nightly-overlay,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [(self: super: {fennel-language-server = super.callPackage ./nix/fennel-language-server.nix {};}) neovim-nightly-overlay.overlay];
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
