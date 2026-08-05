{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPatches = [
    {
      name = "enable_reachability";
      patch = ../reachability.patch;
      structuredExtraConfig = {
        IPV6_REACHABILITY_PROBE = lib.kernel.yes;
      };
    }
  ];

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
    "net.ipv6.conf.eno1.autoconf" = 1;
    "net.ipv6.conf.eno1.accept_ra" = 2;
    "net.ipv6.conf.eno1.accept_ra_rt_info_max_plen" = 64;
  };

  age.identityPaths = [ "/home/nuc/.ssh/nuc" ];

  networking = {
    firewall.enable = false;
    firewall.allowedTCPPorts = [
      8123
      8981
    ];
    networkmanager.unmanaged = [
      "eno1"
    ];
    dhcpcd = {
      IPv6rs = false;
      extraConfig = ''
        noipv6
      '';
    };
    interfaces.eno1 = {
      useDHCP = true;
    };
    defaultGateway6 = {
      address = "fe80::9a9b:cbff:febe:41eb";
      interface = "eno1";
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  system.stateVersion = "26.05";
}
