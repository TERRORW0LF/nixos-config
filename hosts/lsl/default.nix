# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  console = {
    font = "Lat2-Terminus16";
    keyMap = "de-latin1-nodeadkeys";
    # useXkbConfig = true; # use xkb.options in tty.
  };

  # List services that you want to enable:
  services.nginx = {
    enable = true;
    virtualHosts.redirectorBook = {
      serverName = "learn.lucio.surf";
      enableACME = true;
      listen = [
        {
          addr = "194.13.81.46";
          port = 80;
        }
        #{
        #  addr = "[2a03:4000:43:7f0::]";
        #  port = 80;
        #}
      ];
      locations."/.well-known/" = {
        root = "/var/lib/acme/learn.lucio.surf/";
      };
      locations."/".return = "301 https://learn.lucio.surf$request_uri";
    };
    virtualHosts.book = {
      serverName = "learn.lucio.surf";
      root = "/var/www/book";
      enableACME = true;
      onlySSL = true;
      listen = [
        {
          ssl = true;
          addr = "194.13.81.46";
          port = 443;
        }
        #{
        #  ssl = true;
        #  addr = "[2a03:4000:43:7f0::]";
        #  port = 443;
        #}
      ];
      locations."/.well-known/" = {
        root = "/var/lib/acme/lucio.surf/";
      };
      locations."/" = { };
      locations."/404.html" = {
        extraConfig = "internal;";
      };
      extraConfig = "error_page 404 /404.html;";
    };
    virtualHosts.redirector = {
      serverName = "lucio.surf";
      enableACME = true;
      listen = [
        {
          addr = "194.13.81.46";
          port = 80;
        }
        #{
        #  addr = "[2a03:4000:43:7f0::]";
        #  port = 80;
        #}
      ];
      locations."/.well-known/" = {
        root = "/var/lib/acme/lucio.surf/";
      };
      locations."/".return = "301 https://lucio.surf$request_uri";
    };
    virtualHosts.website = {
      serverName = "lucio.surf";
      enableACME = true;
      onlySSL = true;
      listen = [
        {
          ssl = true;
          addr = "194.13.81.46";
          port = 443;
        }
        #{
        #  ssl = true;
        #  addr = "[2a03:4000:43:7f0::]";
        #  port = 443;
        #}
      ];
      locations."/.well-known/" = {
        root = "/var/lib/acme/lucio.surf/";
      };
      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "finn2003minicooper@gmail.com";
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  system.stateVersion = "25.05"; # Did you read the comment?
}
