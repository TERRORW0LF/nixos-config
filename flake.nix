{
  description = "Shared system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };
    nix-matlab = {
      url = "gitlab:doronbehar/nix-matlab";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      agenix,
      nix-matlab,
      ...
    }:
    {
      nixosConfigurations = {
        desktop =
          let
            name = "desktop";
            level = "-28.0";
            input = "alsa_input.usb-Beyerdynamic_FOX_5.00-00.mono-fallback";
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit
                inputs
                name
                level
                input
                ;
            };
            modules = [
              agenix.nixosModules.default
              ./overlays
              ./hosts/base.nix
              ./hosts/desktop
              ./modules/base.nix
              ./modules/secrets.nix
              ./modules/graphics.nix
              ./modules/graphical.nix
              ./modules/sound.nix
              ./modules/printing.nix
              ./modules/git.nix
              ./modules/postgres.nix
              ./modules/neovim.nix
              ./modules/steam.nix
              ./modules/obs.nix
              ./modules/virtualisation.nix
              ./users/finn.nix
            ];
          };
        laptop =
          let
            name = "laptop";
            level = "-28.0";
            input = "alsa_input.pci-0000_04_00.6.HiFi__Mic1__source";
          in
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit
                inputs
                name
                level
                input
                ;
            };
            modules = [
              agenix.nixosModules.default
              ./overlays
              ./hosts/base.nix
              ./hosts/laptop
              ./modules/base.nix
              ./modules/secrets.nix
              ./modules/graphics.nix
              ./modules/graphical.nix
              ./modules/sound.nix
              ./modules/printing.nix
              ./modules/git.nix
              ./modules/postgres.nix
              ./modules/neovim.nix
              ./modules/steam.nix
              ./modules/obs.nix
              ./modules/virtualisation.nix
              ./users/finn.nix
            ];
          };
        rpi =
          let
            name = "rpi";
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs name;
            };
            modules = [
              agenix.nixosModules.default
              ./overlays
              ./hosts/base.nix
              ./hosts/rpi
              ./modules/base.nix
              ./modules/secrets.nix
              ./modules/ssh.nix
              ./modules/git.nix
              ./modules/neovim.nix
              ./modules/virtualisation.nix
              ./users/rpi.nix
            ];
          };
      };
    };
}
