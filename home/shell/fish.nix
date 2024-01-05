{ pkgs }:

let shell = import ./core.nix { inherit pkgs; };
in { fish = { shellAliases = shell.aliases; }; }
