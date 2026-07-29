{ pkgs, ... }:
{
  users.users.remotebuild = {
    isSystemUser = true;
    group = "remotebuild";
    hashedPassword = "!";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBjgHShgh4rolAAZpGWlYGAENnSUfjXokdaojPR7j014 root@rpi"
    ];
    useDefaultShell = true;
  };

  users.groups.remotebuild = { };
  nix.settings.trusted-users = [ "remotebuild" ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
