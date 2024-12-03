{ pkgs, ... }: {
  shellAliases = {
    vi = "nvim";
    vim = "nvim";
    v = "nvim";

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

    groot = "cd (git rev-parse --show-toplevel)";
    cat = "${pkgs.bat}/bin/bat";
  };

  initExtra = ''
    function _tmux()
    {
      # assumes there a session called `HOME` exists
      command tmux attach -t HOME \; choose-tree -s
    }
  '';

}
