{ pkgs, ... }: {
  aliases = {
    vi = "nvim";
    vim = "nvim";
    v = "nvim";

    gs = "git status";
    ga = "git add";
    gc = "git commit";
    gps = "git push";
    gl = "git log";
    gd = "git diff";

    la = "eza -la --git --icons";
    l = "eza -l --git --icons";

    cdr = "cd (git rev-parse --show-toplevel)";
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
