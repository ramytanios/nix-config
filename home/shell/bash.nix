{ pkgs }:
let core = import ./core.nix { inherit pkgs; };
in {
  bash = {
    enable = true;
    inherit (core) shellAliases;
    inherit (core) initExtra;
  };

}
