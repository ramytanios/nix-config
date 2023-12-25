{ inputs, ... }: {
  imports = [ inputs.kauz.homeModules.default ];
  colorschemes.kauz.enable = true;

  # kitty font specification
  programs.kitty.font.size = 12.5;
}
