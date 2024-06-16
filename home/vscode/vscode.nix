{ pkgs, ... }: {
  programs = {
    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        # enkia.tokyo-night
        yzhang.markdown-all-in-one
        ms-python.python
        ms-python.vscode-pylance
        ms-toolsai.jupyter
        humao.rest-client
      ];
      userSettings = {
        "python.languageServer" = "Pylance";
        "jupyter.askForKernelRestart" = false;
        "editor.fontLigatures" = true;
        # "workbench.colorTheme" = "Tokyo Night Storm";
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
