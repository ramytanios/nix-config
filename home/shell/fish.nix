{ pkgs, ... }:

let
  core = import ./core.nix { inherit pkgs; };
in
{
  programs.fish = {
    enable = true;

    plugins = [
      {
        name = "pure";
        inherit (pkgs.fishPlugins.pure) src;
      }
    ];

    interactiveShellInit = ''
      fish_vi_key_bindings
      ${pkgs.thefuck}/bin/thefuck --alias | source
    '';

    functions = { };

    shellAbbrs = {
      fish-reload-config = "source ~/.config/fish/**/*.fish";
      tmux-reload-config = "tmux source-file ~/.config/tmux/tmux.conf";
    };

    inherit (core) shellAliases;
  };
}
