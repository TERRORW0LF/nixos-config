{ pkgs, name, ... }:
{
  # Kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = name; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Shell aliases
  programs.bash.shellAliases = {
    delgen = "deleteGens() { nix profile wipe-history --profile /nix/var/nix/profiles/system \"$@\"; nix store gc; }; deleteGens";
    sdelgen = "sdeleteGens() { sudo nix profile wipe-history --profile /nix/var/nix/profiles/system \"$@\"; sudo nix store gc; }; sdeleteGens";
  };

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

  # Location services for flutter developing
  services.geoclue2.enable = true;
  location.provider = "geoclue2";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  services.fwupd.enable = true;

  # Add extra fonts.
  fonts.packages = with pkgs; [
    corefonts
    nerd-fonts.fira-code
  ];

  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Enable direnv for easy dev environments
  programs.direnv.enable = true;
  programs.dconf.enable = true;

  # Regularly optimise system
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
  };
}
