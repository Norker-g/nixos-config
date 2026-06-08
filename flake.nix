{
  description = "Norker's NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixvim,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.norker-nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./nixos/configuration.nix
        ];
      };

      homeConfigurations."norker" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          nixvim.homeModules.nixvim
          ./home-manager/home.nix
        ];
      };
    };
}
