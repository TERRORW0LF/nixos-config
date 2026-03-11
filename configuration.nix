# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "desktop"; # Define your hostname.
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

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Use wayland for electron / chromium
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [
      pkgs.brgenml1lpr
      pkgs.brgenml1cupswrapper
    ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    ipv6 = true;
    openFirewall = true;
  };

  # Enable SANE for scanning.
  hardware.sane = {
    enable = true;
    brscan5.enable = true;
  };

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    extraLv2Packages = [ pkgs.lsp-plugins ];
    extraConfig.pipewire = {
      "90-normalize-mic" = import config/pipewire.nix { };
    };
  };

  # Location services for flutter developing
  services.geoclue2.enable = true;
  location.provider = "geoclue2";
  services.fwupd.enable = true;

  hardware.amdgpu = {
    opencl.enable = true;
    initrd.enable = true;
  };

  # Postgresql
  services.pgadmin = {
    enable = true;
    initialEmail = "finn2003minicooper@gmail.com";
    initialPasswordFile = "/etc/postgrespw.txt";
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_18;
    ensureDatabases = [
      "finnb"
      "lsl"
    ];
    ensureUsers = [
      {
        name = "finnb";
        ensureDBOwnership = true;
      }
      {
        name = "lsl";
        ensureDBOwnership = true;
      }
    ];
    identMap = ''
      # ArbitraryMapName systemUser DBUser
      superuser_map      root       postgres
      superuser_map      postgres   postgres
      superuser_map      pgadmin    postgres
      superuser_map      finnb      postgres
      # Let other names login as themselves
      superuser_map      /^(.*)$    \1
    '';
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser    auth-method  optional_ident_map
      local sameuser  all       peer         map=superuser_map
      local all       postgres  peer         map=superuser_map
    '';
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.finnb = {
    isNormalUser = true;
    description = "Finn Brandt";
    extraGroups = [
      "networkmanager"
      "wheel"
      "scanner"
      "lp"
    ];
    packages = with pkgs; [
      thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  #nixpkgs.config.showDerivationWarnings = [ "maintainerless" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    let
      system = pkgs.stdenv.hostPlatform.system;
      extensions =
        (import (
          builtins.fetchGit {
            url = "https://github.com/nix-community/nix-vscode-extensions";
            rev = "3c9c62e3505bcb2331f2e36d19dfea4a74d4d962";
          }
        )).extensions.${system};
      extensionsList =
        with extensions.vscode-marketplace-release;
        [
          mkhl.direnv
          gitlab.gitlab-workflow
          jnoortheen.nix-ide
          ms-python.python
          ms-toolsai.jupyter
          rust-lang.rust-analyzer
          llvm-vs-code-extensions.vscode-clangd
          ms-vscode.cmake-tools
          dart-code.flutter
          dart-code.dart-code
          oracle.oracle-java
          myriad-dreamin.tinymist
          zezombye.overpy
          pkief.material-icon-theme
          eamodio.gitlens
          ms-vscode.hexeditor
        ]
        ++ [
          # For extensions that don't work with nix-vscode-extensions
          pkgs.vscode-extensions.vadimcn.vscode-lldb
        ];
    in
    with pkgs;
    [
      neovide
      (vscode-with-extensions.override {
        vscode = vscodium;
        vscodeExtensions = extensionsList;
      })
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
      lazygit
      git
      unzip
      clinfo
      nil
      nixpkgs-fmt
    ];

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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable direnv for easy dev environments
  programs.direnv.enable = true;
  programs.dconf.enable = true;

  # Webbrowser
  programs.firefox.enable = true;

  # Enable neovim for programming
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    configure =
      let
        config = import ./config/neovim { inherit pkgs; };
        plugins = import ./plugins/neovim.nix { inherit pkgs; };
      in
      {
        customRC = config.customRC;
        customLuaRC = config.customLuaRC;
        packages.all.start = plugins;
      };
  };

  # Enable steam for gaming
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-wayland-hotkeys
    ];
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.onedrive.enable = true;
  services.ratbagd.enable = true;

  # Enable virtualization
  programs.virt-manager.enable = true;
  virtualisation = {
    # VM
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
      };
    };

    # Docker
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
      daemon.settings = {
        data-root = "/home/finnb/Docker";
        userland-proxy = false;
        experimental = true;
        metrics-addr = "0.0.0.0:9323";
        ipv6 = true;
        fixed-cidr-v6 = "fd00::/80";
      };
    };
  };

  # Regularly optimise system
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
