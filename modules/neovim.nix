{ pkgs, ... }:
{
  # Enable neovim for programming
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    configure =
      let
        config = import ../config/neovim { inherit pkgs; };
        plugins = import ../plugins/neovim.nix { inherit pkgs; };
      in
      {
        customRC = config.customRC;
        customLuaRC = config.customLuaRC;
        packages.all.start = plugins;
      };
  };
}
