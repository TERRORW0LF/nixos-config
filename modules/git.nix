{ ... }:
{
  programs.git = {
    enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };
      user = {
        name = "Finn Brandt";
        email = "finn2003minicooper@gmail.com";
      };
    };
  };
  programs.lazygit.enable = true;
}
