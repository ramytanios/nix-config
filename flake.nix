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
    kauz.url = "github:buntec/kauz";
    tokyonight.url = "github:ramytanios/tokyonight.nvim";
  };

  outputs =
    inputs@{ self, nixpkgs, home-manager, flake-utils, kauz, tokyonight, ... }:

    let

      machines = [
        {
          name = "nuc";
          os = "nixos";
          user = "ramyt";
          system = flake-utils.lib.system.x86_64-linux;
        }
        {
          name = "macbook-air-m2";
          os = "macos";
          user = "ramytanios";
          system = flake-utils.lib.system.aarch64-darwin;
        }
      ];

      machinesBySystem = builtins.groupBy (machine: machine.system) machines;
      isMacos = machine: machine.os == "macos";

      # Add here overlays
      overlays = [ kauz.overlays.default tokyonight.overlays.default ];

    in {

      # NixOS configuration entry point
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          # specialArgs = {inherit inputs outputs;};
          # > Our main nixos configuration file <
          modules = [ ./system/configuration.nix ];
        };
      };

      # Home manager configuration entry point
      homeConfigurations = builtins.listToAttrs (builtins.map (machine:
        let
          pkgs = import nixpkgs {
            inherit (machine) system;
            inherit overlays;
            config = { allowUnfree = true; };
          };

        in {
          inherit (machine) name;
          value = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = { inherit inputs; };
            modules = [
              {
                home.username = machine.user;
                home.homeDirectory = if (isMacos machine) then
                  "/Users/${machine.user}"
                else
                  "/home/${machine.user}";
              }
              ./home/home.nix
              ./home/home-${machine.os}.nix
            ];
          };
        }) machines);

      # nix run .#hm-switch-macos
      # nix run .#hm-nuc
      apps = builtins.mapAttrs (system: machines:
        builtins.listToAttrs (builtins.map (machine:
          let
            pkgs = import nixpkgs { inherit (machine) system; };
            hmScript = pkgs.writeShellScript "hm-switch-${machine.os}" "${
                inputs.home-manager.packages.${machine.system}.home-manager
              }/bin/home-manager switch --flake ${self}#${machine.name}";
          in {
            name = "hm-switch-${machine.os}";
            value = {
              type = "app";
              program = "${hmScript}";
            };
          }) machines)) machinesBySystem;
    };
}
