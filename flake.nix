{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
		dotfiles = {
			url = "github:sofamaniac/dotfiles";
			flake = false;
		};
    rust-overlay.url = "github:oxalica/rust-overlay";
    nix-colors.url = "github:misterio77/nix-colors";
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    rust-overlay,
    alejandra,
		dotfiles,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    # pkgs = nixpkgs.legacyPackages.${system};
		pkgs = import nixpkgs {
				inherit system;
				config.allowUnfree = true;
		};
  in {
    nixosConfigurations = {
      astolfo = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./modules
          ./hosts/astolfo/configuration.nix
					# Ensure home manager config is rebuilt every time the os config is rebuilt
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.users.sofamaniac = ./home-manager/home.nix;
          }
          ({pkgs, ...}: {
            nixpkgs.overlays = [rust-overlay.overlays.default];
            environment.systemPackages = [pkgs.rust-bin.stable.latest.default];
          })
          {
            environment.systemPackages = [alejandra.defaultPackage.${system}];
          }
        ];
      };
    };
		homeConfigurations = {
			"sofamaniac@astolfo" = home-manager.lib.homeManagerConfiguration {
				pkgs = pkgs;
				modules = [ ./home-manager/home.nix ];
				extraSpecialArgs = { inherit inputs dotfiles; };
			};
		};
  };
}
