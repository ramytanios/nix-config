{ inputs, pkgs, ... }: {
  imports = [ inputs.kauz.homeModules.default ];
  colorschemes.kauz.enable = true;

  # kitty font specification
  programs.kitty.font.size = 15.5;

  home.packages = with pkgs; [ texlive.combined.scheme-full ];

}
