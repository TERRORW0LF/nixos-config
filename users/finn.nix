{ pkgs, ... }:
{
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
}
