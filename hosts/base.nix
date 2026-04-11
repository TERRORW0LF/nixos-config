{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    unzip
    nil
    nixpkgs-fmt
  ];
}
