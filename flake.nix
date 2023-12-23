{
  description = "Home configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, flake-utils, ... }:

    let
      nuc = {
        name = "nuc";
        os = "nixos";
        user = "ramyt";
        system = flake-utils.lib.system.x86_64-linux;
      };

      macbook = {
        name = "macbook-air-m2";
        os = "macos";
        user = "ramytanios";
        system = flake-utils.lib.system.aarch64-darwin;
      };

      system = builtins.currentSystem;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      defaultPackage = { inherit (home-manager.defaultPackage) x86_64-linux; };
      defaultPackage = { inherit (home-manager.defaultPackage) x86_64-darwin; };
      defaultPackage = { inherit (home-manager.defaultPackage) aarch64-darwin; };

      # NixOS configuration entry point
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          # specialArgs = {inherit inputs outputs;};
          # > Our main nixos configuration file <
          modules = [ ./system/configuration.nix ];
        };
      };

      # Home manager configuration entry point
      homeConfigurations.${nuc.name} =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {
              home.username = nuc.user;
              home.homeDirectory = "/home/${nuc.user}";
            }
            ./home/home.nix
            ./home/home-${nuc.os}.nix
          ];
          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };

      homeConfigurations.${macbook.name} =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {
              home.username = macbook.user;
              home.homeDirectory = "/Users/${macbook.user}";
            }
            ./home/home.nix
            ./home/home-${macbook.os}.nix
          ];
          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
    };
}
