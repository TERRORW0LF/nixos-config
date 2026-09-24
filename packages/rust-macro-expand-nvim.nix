{
  buildVimPlugin,
  fetchFromGitHub,
}:
buildVimPlugin {
  pname = "rust-expand-macro-nvim";
  version = "0-unstable-10-09-2023";
  src = fetchFromGitHub {
    owner = "vxpm";
    repo = "rust-expand-macro.nvim";
    rev = "66e6e7bcc2201bd602598317855266c0eaf65085";
    hash = "";
  };
  meta.homepage = "https://github.com/vxpm/rust-expand-macro.nvim";
  meta.hydraPlatforms = [ ];
}
