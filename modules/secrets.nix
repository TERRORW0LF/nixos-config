{ ... }:
{
  age.secrets = {
    ipv6Prefix = {
      file = ../secrets/ipv6Prefix.age;
    };
    pgadminPw = {
      file = ../secrets/pgadminPw.age;
    };
  };
}
