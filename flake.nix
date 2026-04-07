{
  description = "Shared system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-matlab = {
      url = "gitlab:doronbehar/nix-matlab";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
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
              (import ./overlays)
              ./hosts/desktop.nix
              ./modules/base.nix
              ./modules/graphics.nix
              ./modules/sound.nix
              ./modules/printing.nix
              ./modules/git.nix
              ./modules/postgres.nix
              ./modules/neovim.nix
              ./modules/steam.nix
              ./modules/obs.nix
              ./modules/virtualisation.nix
              ./users/finn.nix
              ./hardware-configuration.nix
            ];
          };
        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ];
        };
        rpi = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [ ];
        };
      };
    };
}
