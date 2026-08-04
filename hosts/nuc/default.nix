{
  pkgs,
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

  boot.kernel.sysctl = {
    "net.ipv6.conf.eno1.autoconf" = 1;
    "net.ipv6.conf.eno1.accept_ra" = 1;
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
    interfaces.end0 = {
      useDHCP = true;
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  system.stateVersion = "26.05";
}
