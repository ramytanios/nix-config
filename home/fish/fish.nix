{ pkgs, ... }:

{
  programs.fish = with pkgs; {

    enable = true;

    plugins = [
      {
        name = "pure";
        inherit (fishPlugins.pure) src;
      }
    ];

    interactiveShellInit = ''
      fish_vi_key_bindings
      ${thefuck}/bin/thefuck --alias | source
    '';

    functions = { };

    # we prefer abbreviations over aliases
    shellAbbrs = {
      fish-reload-config = "source ~/.config/fish/**/*.fish";
      tmux-reload-config = "tmux source-file ~/.config/tmux/tmux.conf";

      v = "nvim";
      vi = "nvim";
      vim = "nvim";

      jl = "jupyter-lab";
      jn = "jupyter-notebook";

      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gpt = "git push --follow-tags";
      gl = "git log";
      gd = "git diff";

      la = "eza -la --git --icons";
      l = "eza -l --git --icons";

      scala = "scala-cli";

      groot = "cd (git rev-parse --show-toplevel)";

      cat = "${bat}/bin/bat";

    };

  };
}
