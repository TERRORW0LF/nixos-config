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
    (final: prev: {
      # Your own overlays...
      static-configs = prev.callPackage ../config/static { };
      obs-studio-plugins = prev.obs-studio-plugins // {
        obs-wayland-hotkeys = prev.qt6Packages.callPackage ../packages/obs-wayland-hotkeys.nix { };
      };
    })
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
  ];
}
