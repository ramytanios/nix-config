{
  description = "Home configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    catppuccin.url = "github:catppuccin/nix";

    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";

    dummy-app.url = "github:ramytanios/scala-app-template";
    dummy-app.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      darwin,
      flake-utils,
      catppuccin,
      devenv,
      dummy-app,
      ...
    }:
    let
      inherit (nixpkgs) lib;

      machines = [
        {
          name = "thinkpad";
          user = "ramytanios";
          system = flake-utils.lib.system.x86_64-linux;
        }
        {
          name = "macbook-air-m2";
          user = "ramytanios";
          system = flake-utils.lib.system.aarch64-darwin;
        }
      ];

      machinesBySystem = builtins.groupBy (machine: machine.system) machines;

      isDarwin = system: (builtins.match ".*darwin" system) != null;

      darwinMachines = builtins.filter isDarwin machines;

      nixosMachines = builtins.filter (machine: !isDarwin machine) machines;

      systems = builtins.attrNames machinesBySystem;

      eachSystem = nixpkgs.lib.genAttrs systems;

      pkgsBySystem = builtins.listToAttrs (
        builtins.map (system: {
          name = system;
          value = import nixpkgs {
            inherit system;
            inherit overlays;
            config.allowUnfree = true;
          };
        }) systems
      );

      overlays = [ dummy-app.overlays.default ];

    in
    {

      # dev shells
      devShells = eachSystem (
        system:
        let
          pkgs = pkgsBySystem.${system};
        in
        {
          default = devenv.lib.mkShell {
            inherit inputs pkgs;

            modules = [
              (
                { pkgs, config, ... }:
                {
                  languages.lua.enable = true;
                  languages.nix.enable = true;
                }
              )
            ];
          };
        }
      );

      # NixOS configuration entry point
      nixosConfigurations = builtins.listToAttrs (
        builtins.map (machine: {
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
        }) nixosMachines
      );

      # Darwin configuration entry point
      darwinConfigurations = builtins.listToAttrs (
        builtins.map (machine: {
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
        }) darwinMachines
      );

      # Home manager configuration entry point
      # Attribute set machine name -> home manager configuration
      homeConfigurations = builtins.listToAttrs (
        builtins.map (
          machine:
          let
            pkgs = pkgsBySystem.${machine.system};
          in
          {
            inherit (machine) name;
            value = home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              extraSpecialArgs = { inherit inputs; };
              modules = [
                {
                  home.username = machine.user;
                  home.homeDirectory =
                    if (isDarwin machine.system) then "/Users/${machine.user}" else "/home/${machine.user}";
                }
                catppuccin.homeModules.catppuccin
                ./home/home.nix
                ./home/home-${machine.name}.nix
              ];
            };
          }
        ) machines
      );

      apps = builtins.mapAttrs (
        system: machines:
        builtins.listToAttrs (
          lib.flatten (
            builtins.map (
              machine:
              let
                pkgs = pkgsBySystem.${machine.system};

                hmScript = pkgs.writeShellScript "hm-switch-${machine.name}" "${
                  inputs.home-manager.packages.${machine.system}.home-manager
                }/bin/home-manager switch --flake ${self}#${machine.name}";

                rebuildScript = pkgs.writeShellScript "rebuild-${machine.name}" (
                  if (isDarwin machine) then
                    "${
                      self.darwinConfigurations.${machine.name}.system
                    }/sw/bin/darwin-rebuild switch --flake ${self}#${machine.name}"
                  else
                    "${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake ${self}#${machine.name}"
                );

                cleanScript = pkgs.writeShellScript "clean-${machine.name}" "nix-collect-garbage --delete-older-than 15d";

              in
              [
                {
                  name = "hm-switch-${machine.name}";
                  value = {
                    type = "app";
                    program = "${hmScript}";
                  };
                }
                {
                  name = "rebuild-${machine.name}";
                  value = {
                    type = "app";
                    program = "${rebuildScript}";
                  };
                }
                {
                  name = "clean-${machine.name}";
                  value = {
                    type = "app";
                    program = "${cleanScript}";
                  };
                }
              ]
            ) machines
          )
        )
      ) machinesBySystem;
    };
}
