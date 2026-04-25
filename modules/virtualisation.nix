{ ... }:
{
  programs.virt-manager.enable = true;
  virtualisation = {
    # VM
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
      };
    };

    # Docker
    docker = {
      enable = true;
      daemon.settings = {
        userland-proxy = false;
        experimental = true;
        metrics-addr = "0.0.0.0:9323";
        ipv6 = true;
        fixed-cidr-v6 = "fd00:dead:beef:bead::/64";
      };
    };
  };
}
