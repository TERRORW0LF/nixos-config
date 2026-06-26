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

  services.pipewire = {
    extraConfig = {
      pipewire."99-allow-sample-rates" = {
        "context.properties" = {
          "default.clock.allowed-rates" = [
            44100
            48000
            88200
            96000
            176400
            192000
          ];
        };
      };
    };
    wireplumber.extraConfig."99-disable-suspend" = {
      "monitor.alsa.rules" = [
        {
          matches = [
            {
              # Matches all sources
              "node.name" =
                "~alsa_output.usb-TOPPING_DX1_II_00MMG-0QK05-V9UPF-SEVCM-DPCZ5-0XG64-00.HiFi__Headphones__sink";
            }

          ];
          actions = {
            update-props = {
              "session.suspend-timeout-seconds" = 0;
              "dither.method" = "wannamaker3"; # add dither of desired shape
              "dither.noise" = 2; # add additional bits of noise
            };
          };
        }
      ];
    };
  };

  age.identityPaths = [ "/home/finnb/.ssh/desktop" ];

  services.ratbagd.enable = true;
  system.stateVersion = "25.05"; # Did you read the comment?
}
