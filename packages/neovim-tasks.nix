{
  buildVimPlugin,
  fetchFromGitHub,
  vimPlugins,
}:
buildVimPlugin {
  pname = "neovim-tasks";
  version = "0-unstable-26-03-2026";
  src = fetchFromGitHub {
    owner = "Shatur";
    repo = "neovim-tasks";
    rev = "66e6e7bcc2201bd602598317855266c0eaf65085";
    hash = "sha256-cmcfOk4/WY8b2t9P63sdXGk3V+qbpgoscV8gNUomEc0=";
  };
  dependencies = with vimPlugins; [ plenary-nvim ];
  meta.homepage = "https://github.com/Shatur/neovim-tasks";
  meta.hydraPlatforms = [ ];
}
