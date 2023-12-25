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

    shellAliases = {
      # vim aliases
      vi = "nvim";
      vim = "nvim";
      v = "nvim";

      # git aliases
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gps = "git push";
      gl = "git log";

      # ls 
      la = "eza -la --git --icons";
      l = "eza -l --git --icons";

      cdr = "cd (git rev-parse --show-toplevel)";

      cat = "${pkgs.bat}/bin/bat";

    };
  };

}
