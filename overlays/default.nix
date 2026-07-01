{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  nixpkgs.overlays = [
    inputs.nix-matlab.overlay
    (
      final: prev:
      let
        buildVimPlugin = prev.vimUtils.buildVimPlugin;
      in
      {
        vimPlugins = prev.vimPlugins.extend (
          final': prev': {
            direnv-nvim = prev.callPackage ../packages/direnv-nvim.nix {
              inherit buildVimPlugin;
            };
            neovim-tasks = prev.callPackage ../packages/neovim-tasks.nix {
              inherit buildVimPlugin;
            };
          }
        );
      }
    )
    (final: prev: {
      linuxPackages = prev.linuxPackages.extend (
        final': prev': {
          pivccu = prev'.callPackage ../packages/pivccu-modules-dkms.nix { };
        }
      );
      linuxPackages_latest = prev.linuxPackages_latest.extend (
        final': prev': {
          pivccu = prev'.callPackage ../packages/pivccu-modules-dkms.nix { };
        }
      );
    })
  ];
}
