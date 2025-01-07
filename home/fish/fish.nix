{ pkgs, ... }:

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

      # vim
      v = "nvim";
      vi = "nvim";
      vim = "nvim";

      # jupyter-lab
      jl = "jupyter-lab";
      jn = "jupyter-notebook";

      # git
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gpt = "git push --follow-tags";
      gl = "git log";
      gd = "git diff";

      #ls
      la = "eza -la --git --icons";
      l = "eza -l --git --icons";

      # scala
      scala = "scala-cli";

      groot = "cd (git rev-parse --show-toplevel)";

      cat = "${pkgs.bat}/bin/bat";

    };

  };
}
