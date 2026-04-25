let
  desktop = "";
  laptop = "";
  rpi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILLdZuQRtcP8D2npYPHnbox+Szo/SvF2oQsZz8i1ga3+";
in
{
  "ipv6Prefix.age".publicKeys = [ rpi ];
}
