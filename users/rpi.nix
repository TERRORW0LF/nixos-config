{ pkgs, ... }:
{
  users = {
    mutableUsers = false;
    users = {
      rpi = {
        isNormalUser = true;
        hashedPassword = "$y$j9T$g4aR6DDD7hoC2kFpLHKEx1$2tUMqiD2Y/5JDIeivR6nqHMGlr7Tk1RgqxW9LW3zqT1";
        openssh.authorizedKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGqMQ5S+y5FH7/ukXQoJC4psYkgApFalavlMxp9fwutT finnb"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDvk1S0bSDv4I9xddjynZK/RgNmHU7gshFECnCGBzNYU finnb"
        ];
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };
      root = {
        hashedPassword = "!";
      };
    };
  };
}
