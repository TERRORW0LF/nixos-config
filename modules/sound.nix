{
  pkgs,
  level,
  input,
  ...
}:
{
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
      "90-normalize-mic" = pkgs.callPackage ../config/pipewire { inherit level input; };
    };
  };
}
