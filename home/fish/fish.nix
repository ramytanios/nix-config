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

    functions = {
      fish_mode_prompt = {
        body = ''
            switch $fish_bind_mode
            case default
              set_color --bold red
              echo '[N]'
            case insert
              set_color --bold green
              echo '[I]'
            case replace_one
              set_color --bold green
              echo '[R]'
            case visual
              set_color --bold brmagenta
              echo '[V]'
            case '*'
              set_color --bold red
              echo '[?]'
          end
          set_color normal 
        '';
      };
    };

  };

}
