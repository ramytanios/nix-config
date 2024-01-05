{ pkgs }:

let core = import ./core.nix { inherit pkgs; };
in { fish = { inherit (core) shellAliases; }; }
