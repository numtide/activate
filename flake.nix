{
  description = "activate - a small resource converging tool";

  outputs = { self, nixpkgs }: {
    devShells.x86_64-linux.default =
      with nixpkgs.legacyPackages.x86_64-linux;
      mkShell {
        packages = [ go ];
      };
  };
}
