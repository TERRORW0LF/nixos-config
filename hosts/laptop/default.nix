{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader.
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovide
    (callPackage ../../modules/vscode.nix { })
    haruna
    kdePackages.kcalc
    brave
    vesktop
    osu-lazer-bin
    audacity
    losslesscut-bin
    libreoffice-qt
    xournalpp
    krita
    simple-scan
    hunspell
    hunspellDicts.en_US
    hunspellDicts.de_DE
    clinfo
  ];

  age.identityPaths = [ "/home/finnb/.ssh/laptop" ];

  systemd.user.services.asound-restore = {
    enable = true;
    after = [ "sound.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.lib.getExe' pkgs.alsa-utils "alsactl"} --file ${pkgs.static-configs}/alsa/asound.state restore";
    };
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}
