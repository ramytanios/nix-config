{ pkgs, ... }:

let core = import ./core.nix { inherit pkgs; };
in { programs.fish = { inherit (core) shellAliases; }; }
