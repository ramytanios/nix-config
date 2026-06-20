{
  description = "Home configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    catppuccin.url = "github:catppuccin/nix";

    dummy-app.url = "github:ramytanios/scala-app-template";
    dummy-app.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      darwin,
      catppuccin,
      dummy-app,
      ...
    }:
    let
      inherit (nixpkgs) lib;

      machines = [
        {
          name = "macbook-air-m2";
          user = "ramytanios";
          system = "aarch64-darwin";
        }
        {
          # HM inside multipass guest (Ubuntu) on Apple Silicon
          name = "multipass-guest";
          user = "ramytanios";
          system = "aarch64-linux";
        }
        {
          # HM inside multipass guest (Ubuntu) on x86_64 (e.g. Windows host)
          name = "multipass-guest-x86";
          user = "ramytanios";
          system = "x86_64-linux";
        }
        {
          # WSL
          name = "wsl";
          user = "ramytanios";
          system = "x86_64-linux";
        }
      ];

      machinesBySystem = builtins.groupBy (machine: machine.system) machines;

      isDarwin = machine: (builtins.match ".*darwin" machine.system) != null;

      darwinMachines = builtins.filter isDarwin machines;
      nixosMachines = builtins.filter (machine: !isDarwin machine) machines;

      systems = builtins.attrNames machinesBySystem;

      eachSystem = lib.genAttrs systems;

      overlays = [ dummy-app.overlays.default ];

      pkgsBySystem = builtins.listToAttrs (
        builtins.map (system: {
          name = system;
          value = import nixpkgs {
            inherit system overlays;
            config.allowUnfree = true;
          };
        }) systems
      );

    in
    {

      devShells = eachSystem (
        system:
        let
          pkgs = pkgsBySystem.${system};
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              lua
              lua-language-server
              nixfmt-rfc-style
            ];
          };
        }
      );

      nixosConfigurations = builtins.listToAttrs (
        builtins.map (machine: {
          inherit (machine) name;
          value = nixpkgs.lib.nixosSystem {
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
                    if isDarwin machine then "/Users/${machine.user}" else "/home/${machine.user}";
                }
                catppuccin.homeModules.catppuccin
                ./home/home.nix
                ./home/home-${machine.name}.nix
              ];
            };
          }
        ) machines
      );

      apps = eachSystem (
        system:
        let
          machines = machinesBySystem.${system};
        in
        lib.mergeAttrsList (
          builtins.map (
            machine:
            let
              pkgs = pkgsBySystem.${machine.system};

              hmScript = pkgs.writeShellScript "hm-switch-${machine.name}" ''
                ${inputs.home-manager.packages.${machine.system}.home-manager}/bin/home-manager switch --flake ${self}#${machine.name}
              '';

              rebuildScript = pkgs.writeShellScript "rebuild-${machine.name}" (
                if isDarwin machine then
                  ''${self.darwinConfigurations.${machine.name}.system}/sw/bin/darwin-rebuild switch --flake ${self}#${machine.name}''
                else
                  ''${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake ${self}#${machine.name}''
              );

              cleanScript = pkgs.writeShellScript "clean-${machine.name}" ''
                nix-collect-garbage --delete-older-than 15d
              '';

            in
            {
              "hm-switch-${machine.name}" = {
                type = "app";
                program = "${hmScript}";
              };
              "rebuild-${machine.name}" = {
                type = "app";
                program = "${rebuildScript}";
              };
              "clean-${machine.name}" = {
                type = "app";
                program = "${cleanScript}";
              };
            }
          ) machines
        )
      );
    };
}
