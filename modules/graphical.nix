{ ... }:
{
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

  # Webbrowser
  programs.firefox = {
    enable = true;
    policies = {
      NoDefaultBookmarks = true;
      DisableAccounts = true;
      Homepage = {
        StartPage = "previous-session";
      };
      FirefoxHome = {
        Search = true;
        TopSites = true;
        SponsoredTopSites = false;
        Highlights = true;
        Pocket = false;
        Stories = false;
        SponsoredPocket = false;
        SponsoredStories = false;
        Snippets = false;
        Locked = false;
      };
      Cookies = {
        Behavior = "partition-foreign";
        Locked = true;
      };
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
        SuspectedFingerprinting = true;
        Category = "strict";
        BaselineExceptions = true;
        ConvenienceExceptions = false;
      };
      SearchEngines = {
        PreventInstalls = true;
        Default = "DuckDuckGo";
        Remove = [
          "Perplexity"
          "Bing"
          "Ecosia"
        ];
      };
      AIControls = {
        Default = {
          Value = "available";
          Locked = false;
        };
        SmartTabGroups = {
          Value = "blocked";
        };
        SidebarChatbot = {
          Value = "blocked";
        };
        SmartWindow = {
          Value = "blocked";
        };
      };
      ExtensionSettings = {
        "addon@darkreader.org" = {
          installation_mode = "normal_installed";
          default_area = "navbar";
          private_browsing = true;
        };
        "uBlock0@raymondhill.net" = {
          installation_mode = "normal_installed";
          default_area = "navbar";
          private_browsing = true;
        };
      };
      Preferences = {
        "browser.taskbar-tabs.enabled".Value = true;
        "widget.use-xdg-desktop-portal.file-picker".Value = 1;
      };
    };
  };
}
