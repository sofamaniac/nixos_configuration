{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
    };
    dotfiles = {
      url = "github:sofamaniac/dotfiles";
      flake = false;
    };
    nix-colors.url = "github:misterio77/nix-colors";
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    alejandra,
    dotfiles,
    catppuccin,
    nixos-hardware,
    sops-nix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    # allow unfree for discord
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      astolfo = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./modules
          ./hosts/astolfo/common.nix
          # Framework hardware support
          nixos-hardware.nixosModules.framework-13-7040-amd
          catppuccin.nixosModules.catppuccin
          {
            environment.systemPackages = [alejandra.defaultPackage.${system}];
          }
          sops-nix.nixosModules.sops
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
