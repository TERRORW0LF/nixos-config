{ pkgs, ... }:
{
  # Postgresql
  services.pgadmin = {
    enable = true;
    initialEmail = "finn2003minicooper@gmail.com";
    initialPasswordFile = "/etc/postgrespw.txt";
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_18;
    ensureDatabases = [
      "finnb"
      "lsl"
    ];
    ensureUsers = [
      {
        name = "finnb";
        ensureDBOwnership = true;
      }
      {
        name = "lsl";
        ensureDBOwnership = true;
      }
    ];
    identMap = ''
      # ArbitraryMapName systemUser DBUser
      superuser_map      root       postgres
      superuser_map      postgres   postgres
      superuser_map      pgadmin    postgres
      superuser_map      finnb      postgres
      # Let other names login as themselves
      superuser_map      /^(.*)$    \1
    '';
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser    auth-method  optional_ident_map
      local sameuser  all       peer         map=superuser_map
      local all       postgres  peer         map=superuser_map
    '';
  };
}
