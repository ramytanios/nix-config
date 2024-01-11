{ config, pkgs, ... }: {
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;

  # Enable sudo authentication with Touch ID
  security.pam.enableSudoTouchIdAuth = true;

  # Auto hide dock
  system.defaults.dock.autohide = true;

  nix.package = pkgs.nix; # this is the default

  networking.hostName = "macbook-air-m2";

  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs;
    [
      # kitty
    ];

  # automatic garbage collection
  # https://nixos.wiki/wiki/Storage_optimization
  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 0;
      Minute = 0;
    };
    options = "--delete-older-than 30d";
  };

  # Fonts 
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs;
    [
      (nerdfonts.override {
        fonts = [ "FiraCode" "JetBrainsMono" "DroidSansMono" ];
      })
    ];

  # homebrew 
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    casks = [
      # "discord"
      "docker"
      # "firefox"
      # "kitty"
      # "mattermost"
      "telegram"
      "whatsapp"
    ];
  };

  # ZSH
  programs.zsh.enable = true;

  # Allow unfree packages 
  nixpkgs.config.allowUnfree = true;

  users.users.ramytanios = {
    name = "ramytanios";
    home = "/Users/ramytanios";
  };
}
