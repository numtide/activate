{
  description = "activate - a small resource converging tool";

  inputs.flake-parts.url = "github:hercules-ci/flake-parts";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.treefmt-config.url = "github:numtide/treefmt-nix";

  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports = [
        inputs.treefmt-config.flakeModule
      ];
      perSystem = { self', lib, config, pkgs, ... }: {
        # configure treefmt
        treefmt.projectRootFile = "flake.nix";
        treefmt.programs.gofmt.enable = true;
        treefmt.programs.nixpkgs-fmt.enable = true;

        # invoked by `nix fmt`
        formatter = config.treefmt.build.wrapper;

        # setup a developer shell
        devShells.default = pkgs.mkShell {
          packages = [ pkgs.go ];
        };
      };
    };
}
