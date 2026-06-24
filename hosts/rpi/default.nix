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
    "net.ipv6.end0.accept_ra" = 2;
    "net.ipv6.end0.accept_ra_rt_info_max_plen" = 64;
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

  networking =
    let
      prefix = lib.strings.removeSuffix "\n" (builtins.readFile ../../secrets/ipv6Prefix.txt);
    in
    {
      firewall.enable = false;
      firewall.allowedTCPPorts = [
        8123
        8981
      ];
      dhcpcd = {
        IPv6rs = false;
        extraConfig = "noipv6";
      };
      networkmanager.unmanaged = [ "end0" ];
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
        useDHCP = false;
        ipv4 = {
          addresses = [
            {
              address = "192.168.178.5";
              prefixLength = 24;
            }
          ];
          routes = [
            {
              address = "192.168.178.0";
              prefixLength = 24;
              options = {
                mtu = "600";
              };
            }
            {
              address = "0.0.0.0";
              prefixLength = 0;
              via = "192.168.178.1";
              options = {
                mtu = "600";
              };
            }
          ];
        };
        ipv6 = {
          addresses = [
            {
              address = "${prefix}:cc7d:a1b1:b727:4780";
              prefixLength = 64;
            }
            {
              address = "fd97:58c:9bb1:0:cc7d:a1b1:b727:4781";
              prefixLength = 64;
            }
            {
              address = "fe80::cc7d:a1b1:b727:4782";
              prefixLength = 64;
            }
          ];
          routes = [
            {
              address = "fe80::";
              prefixLength = 64;
              options = {
                mtu = "1024";
              };
            }
            {
              address = "fd97:58c:9bb1::";
              prefixLength = 64;
              options = {
                mtu = "600";
              };
            }
            {
              address = "${prefix}::";
              prefixLength = 64;
              options = {
                mtu = "600";
              };
            }
            {
              address = "fd97:58c:9bb1::";
              prefixLength = 64;
              via = "fe80::9a9b:cbff:febe:41eb";
              options = {
                mtu = "605";
              };
            }
            {
              address = "${prefix}::";
              prefixLength = 56;
              via = "fe80::9a9b:cbff:febe:41be";
              options = {
                mtu = "600";
              };
            }
            {
              address = "::";
              prefixLength = 0;
              via = "fe80::9a9b:cbff:febe:41eb";
              options = {
                mtu = "600";
              };
            }
            {
              address = "${prefix}:cc7d:a1b1:b727:4782";
              prefixLength = 128;
              options = {
                mtu = "600";
              };
            }
          ];
        };
      };
      defaultGateway = {
        address = "192.168.178.1";
        interface = "end0";
      };
      defaultGateway6 = {
        address = "fe80::9a9b:cbff:febe:41eb";
        interface = "end0";
      };
      nameservers = [
        "192.168.178.1"
        "fd97:58c:9bb1:0:9a9b:cbff:febe:41eb"
        "${prefix}:9a9b:cbff:febe:41eb"
      ];
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
