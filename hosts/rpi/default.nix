{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.package = pkgs.nixVersions.latest;

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];

  networking.firewall.allowedTCPPorts = [ 8123 ];

  system.stateVersion = "25.11";
}
