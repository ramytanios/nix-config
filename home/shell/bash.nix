{ pkgs }:
let shell = import ./core.nix { inherit pkgs; };
in {
  bash = {
    enable = true;
    shellAliases = shell.aliases;
    inherit (shell) initExtra;
  };

}
