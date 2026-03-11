{ pkgs }:
let
  resolveNix =
    file: dir:
    (
      if pkgs.lib.strings.hasSuffix "nix" file then
        import ./${dir}/${file} { inherit pkgs; }
      else
        builtins.readFile ./${dir}/${file}
    );
in
{
  customRC = builtins.concatStringsSep "\n" (
    builtins.map (file: resolveNix file "vim") (builtins.attrNames (builtins.readDir ./vim))
  );
  customLuaRC = builtins.concatStringsSep "\n" (
    builtins.map (file: resolveNix file "lua") (builtins.attrNames (builtins.readDir ./lua))
  );
}
