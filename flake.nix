{
  description = "nix build file generator for rust crates";

  inputs = {
    utils.url = github:numtide/flake-utils;
  };

  outputs = { nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
          crate2nix = import ./. { inherit pkgs; };
       in
      {
        packages.default = crate2nix;
        apps.default = {
          type = "app";
          program = "${crate2nix}/bin/crate2nix";
        };
      });
}
