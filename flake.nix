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

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    rust-overlay,
    alejandra,
    dotfiles,
    catppuccin,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    #pkgs = nixpkgs.legacyPackages.${system};
    # allow unfree for discord
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      astolfo = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs dotfiles;};
        modules = [
          ./modules
          ./hosts/astolfo/configuration.nix
          catppuccin.nixosModules.catppuccin
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
        modules = [./home-manager/home.nix catppuccin.homeManagerModules.catppuccin];
        extraSpecialArgs = {inherit inputs dotfiles;};
      };
    };
  };
}
