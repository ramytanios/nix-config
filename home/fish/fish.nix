{ pkgs, ... }: {

  programs.fish = {
    enable = true;
    plugins = [{
      name = "pure";
      inherit (pkgs.fishPlugins.pure) src;
    }];

    interactiveShellInit = ''
      fish_vi_key_bindings
      ${pkgs.thefuck}/bin/thefuck --alias | source
    '';

    shellInit = ''
      set pure_color_mute yellow
    '';

    functions = { };

  };

}
