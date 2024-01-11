{
  description = "Home configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    colorscheme.url = "github:ramytanios/colorschemes-nix-flake";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, darwin, flake-utils
    , colorscheme, ... }:

    let
      inherit (nixpkgs) lib;

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
      isDarwin = machine: machine.os == "macos";
      darwinMachines = builtins.filter isDarwin machines;
      nixosMachines = builtins.filter (machine: !isDarwin machine) machines;

      # Add here overlays
      overlays = [ colorscheme.overlays.kauz.default ];

    in {

      # NixOS configuration entry point
      nixosConfigurations = builtins.listToAttrs (builtins.map (machine: {
        inherit (machine) name;
        value = nixpkgs.lib.nixosSystem {
          # specialArgs = {inherit inputs outputs;};
          # > Our main nixos configuration file <
          modules = [
            {
              nixpkgs.overlays = overlays;
              nixpkgs.config.allowUnfree = true;
            }
            ./system/configuration.nix
          ];
        };
      }) nixosMachines);

      # Darwin configuration entry point 
      darwinConfigurations = builtins.listToAttrs (builtins.map (machine: {
        inherit (machine) name;
        value = darwin.lib.darwinSystem {
          inherit (machine) system;
          modules = [
            {
              nixpkgs.overlays = overlays;
              nixpkgs.config.allowUnfree = true;
            }
            ./system/configuration-darwin.nix
          ];
        };
      }) darwinMachines);

      # Home manager configuration entry point
      # Attribute set machine name -> home manager configuration
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
                home.homeDirectory = if (isDarwin machine) then
                  "/Users/${machine.user}"
                else
                  "/home/${machine.user}";
              }
              ./home/home.nix
              ./home/home-${machine.os}.nix
            ];
          };
        }) machines);

      apps = builtins.mapAttrs (system: machines:
        builtins.listToAttrs (lib.flatten (builtins.map (machine:
          let
            pkgs = import nixpkgs { inherit (machine) system; };

            hmScript = pkgs.writeShellScript "hm-switch-${machine.os}" "${
                inputs.home-manager.packages.${machine.system}.home-manager
              }/bin/home-manager switch --flake ${self}#${machine.name}";

            rebuildScript = pkgs.writeShellScript "rebuild-${machine.os}"
              (if (isDarwin machine) then
                "${
                  self.darwinConfigurations.${machine.name}.system
                }/sw/bin/darwin-rebuild} switch --flake ${self}#${machine.name}"
              else
                "${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake ${self}#${machine.name}");

            cleanScript = pkgs.writeShellScript "clean-${machine.os}"
              "nix-collect-garbage --delete-older-than 15d";

          in [
            {
              name = "hm-switch-${machine.os}";
              value = {
                type = "app";
                program = "${hmScript}";
              };
            }
            {
              name = "rebuild-${machine.os}";
              value = {
                type = "app";
                program = "${rebuildScript}";
              };
            }
            {
              name = "clean-${machine.os}";
              value = {
                type = "app";
                program = "${cleanScript}";
              };
            }
          ]) machines))) machinesBySystem;
    };
}
