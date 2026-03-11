{ pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovide
    (callPackage ../modules/vscode.nix { })
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
    hunspell
    hunspellDicts.en_US
    hunspellDicts.de_DE
    ripgrep
    unzip
    clinfo
    nil
    nixpkgs-fmt
  ];

  services.ratbagd.enable = true;
  system.stateVersion = "25.05"; # Did you read the comment?
}
