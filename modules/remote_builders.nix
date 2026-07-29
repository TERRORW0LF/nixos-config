{ pkgs, ... }:
{
  nix.distributedBuilds = true;

  nix.buildMachines = [
    {
      hostName = "desktop.fritz.box";
      sshUser = "remotebuild";
      sshKey = "/root/.ssh/remotebuild";
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      supportedFeatures = [
        "nixos-test"
        "big-parallel"
        "kvm"
      ];
    }
  ];
}
