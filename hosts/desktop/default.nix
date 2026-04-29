{ pkgs, config, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader.
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [ new-lg4ff ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovide
    (callPackage ../../modules/vscode.nix { })
    matlab
    haruna
    kdePackages.kcalc
    brave
    vesktop
    prismlauncher
    (lutris.override {
      extraLibraries = pkgs: [ ];
      extraPkgs = pkgs: [ ];
    })
    osu-lazer-bin
    audacity
    losslesscut-bin
    davinci-resolve
    libreoffice-qt
    xournalpp
    krita
    simple-scan
    piper
    oversteer
    hunspell
    hunspellDicts.en_US
    hunspellDicts.de_DE
    clinfo
  ];

  age.identityPaths = [ "/home/finnb/.ssh/desktop" ];

  services.ratbagd.enable = true;
  system.stateVersion = "25.05"; # Did you read the comment?
}
