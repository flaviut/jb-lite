{
  description = "JetBrains Lite - A lightweight, CLI-only package manager for JetBrains IDEs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = { self, nixpkgs, flake-utils, treefmt-nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        package = pkgs.callPackage ./package.nix { };
        treefmtEval = treefmt-nix.lib.evalModule pkgs {
          projectRootFile = "flake.nix";
          programs.nixpkgs-fmt.enable = true;
          programs.ruff.format = true;
          programs.mdformat.enable = true;
          programs.shfmt.enable = true;
        };
      in
      {
        packages = {
          default = package;
          jb-lite = package;
        };

        apps.default = {
          type = "app";
          program = "${package}/bin/jb-lite";
        };

        formatter = treefmtEval.config.build.wrapper;
        checks.formatting = treefmtEval.config.build.check self;

        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.python3
            treefmtEval.config.build.wrapper
          ];
        };
      }
    );
}
