let
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGqMQ5S+y5FH7/ukXQoJC4psYkgApFalavlMxp9fwutT";
  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDvk1S0bSDv4I9xddjynZK/RgNmHU7gshFECnCGBzNYU";
  rpi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILLdZuQRtcP8D2npYPHnbox+Szo/SvF2oQsZz8i1ga3+";
  lsl = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEz1RlPcoC5fHhrpGUdV2LGPwQizptHukJ0ky5CUEKtN";
in
{
  "pgadminPw.age".publicKeys = [
    laptop
    desktop
    rpi
    lsl
  ];
}
