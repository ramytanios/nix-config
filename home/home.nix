{ config, pkgs, ... }: {

  imports =
    [ ./tmux/tmux.nix ./kitty/kitty.nix ./nvim/nvim.nix ./shell/default.nix ];

  home = {

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "23.11"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = let
      hello-world = pkgs.writeShellScriptBin "hello-world" ''
        echo "Hello world, I am ${config.home.username}"
      '';

      python-packages = ps:
        with ps; [
          pydantic
          mypy
          python-lsp-server
          requests
          pandas
          numpy
          scipy
          matplotlib
          ipython
          scikitlearn
          seaborn
          statsmodels
          jupyterlab
          notebook
          joblib
          multimethod
        ];

      python-with-packages = pkgs.python3.withPackages python-packages;

    in with pkgs; [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pkgs.hello

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
      bat
      coursier
      csvlens
      duf
      eza
      fd
      figlet
      fx
      fzf
      # git-summary
      glow
      gnumake
      gum
      hello-world
      httpie
      jdk
      just
      killall
      # live-server
      metals
      ncdu
      nodejs
      podman
      python-with-packages
      ripgrep
      ruff
      sbt
      scala-cli
      stow
      thefuck
      tree
      treefmt
      typst
      typst-live
      unzip
      # watch
      zip
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. If you don't want to manage your shell through Home
    # Manager then you have to manually source 'hm-session-vars.sh' located at
    # either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/ramy/etc/profile.d/hm-session-vars.sh
    #
    sessionVariables = {
      # EDITOR = "emacs";
    };
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
        aliases = { };
        editor = "nvim";
        version = 1; # see issue https://github.com/cli/cli/issues/8462
      };
    };

    git = {
      enable = true;
      userEmail = "ramy.tanios@gmail.com";
      userName = "Ramy Tanios";
      diff-so-fancy.enable = true;
    };

    java.enable = true;

    ssh.enable = true;

    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        enkia.tokyo-night
        yzhang.markdown-all-in-one
        ms-python.python
        ms-python.vscode-pylance
        ms-toolsai.jupyter
      ];
      userSettings = {
        "python.languageServer" = "Pylance";
        "jupyter.askForKernelRestart" = false;
        "editor.fontLigatures" = true;
        "workbench.colorTheme" = "Tokyo Night Storm";
        "workbench.iconTheme" = "Monokai Pro Icons";
        "editor.fontFamily" = "JetBrains Nerd Font Mono";
        "editor.fontSize" = 15;
        "vim.insertModeKeyBindings" = [{
          "before" = [ "j" "k" ];
          "after" = [ "<Esc>" ];
        }];

      };
      keybindings = [
        {
          "key" = "ctrl+j";
          "command" = "selectNextSuggestion";
          "when" =
            "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
        }

        {
          "key" = "ctrl+k";
          "command" = "selectPrevSuggestion";
          "when" =
            "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
        }
      ];
    };

  };
}
