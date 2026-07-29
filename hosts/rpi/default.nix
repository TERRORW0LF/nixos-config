{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.package = pkgs.nixVersions.latest;

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel.
  boot.kernelPackages = pkgs.linuxPackages;
  boot.kernelPatches = [
    {
      name = "enable_reachability";
      patch = ./reachability.patch;
      structuredExtraConfig = {
        IPV6_REACHABILITY_PROBE = lib.kernel.yes;
      };
    }
  ];
  boot.extraModulePackages = [ config.boot.kernelPackages.pivccu ];
  boot.kernelModules = [
    "hci_uart"
    "bluetooth"
    "btusb"
    "btbcm"
    "bnep"
    "ip6table_filter"
    "generic_raw_uart"
    "eq3_char_loop"
  ];

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
    "net.ipv6.conf.end0.autoconf" = 1;
    "net.ipv6.conf.end0.accept_ra" = 2;
    "net.ipv6.conf.end0.accept_ra_rt_info_max_plen" = 64;
  };

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];

  age.identityPaths = [ "/home/rpi/.ssh/rpi" ];

  services.udev.extraRules = ''
    ATTRS{idVendor}=="1b1f", ATTRS{idProduct}=="c020", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="1b1f", ATTRS{idProduct}=="c00f", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6f70", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="8c07", ENV{ID_MM_DEVICE_IGNORE}="1"
  '';

  networking = {
    firewall.enable = false;
    firewall.allowedTCPPorts = [
      8123
      8981
    ];
    networkmanager.unmanaged = [
      "end0"
      "wpan0"
    ];
    dhcpcd = {
      IPv6rs = false;
      extraConfig = ''
        noipv6
      '';
    };
    macvlans.ccu-shim = {
      mode = "bridge";
      interface = "end0";
    };
    interfaces.ccu-shim = {
      useDHCP = false;
      ipv4 = {
        addresses = [
          {
            address = "192.168.178.6";
            prefixLength = 32;
          }
        ];
        routes = [
          {
            address = "192.168.178.7";
            prefixLength = 32;
            options = {
              protocol = "static";
            };
          }
        ];
      };
    };
    interfaces.end0 = {
      useDHCP = true;
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  systemd.services.btattach = {
    before = [ "bluetooth.service" ];
    after = [ "dev-ttyAMA0.device" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.bluez}/bin/btattach -B /dev/ttyAMA0 -P bcm -S 3000000";
    };
  };

  system.stateVersion = "25.11";
}
