{
  buildVimPlugin,
  fetchFromGitHub,
}:
buildVimPlugin {
  pname = "rust-expand-macro-nvim";
  version = "0-unstable-2026-09-28";
  src = fetchFromGitHub {
    owner = "TERRORW0LF";
    repo = "rust-expand-macro.nvim";
    rev = "d42adafa967cf2a6ee4fd264c3b19cf70c216b3e";
    hash = "sha256-R1dUiW7OziD5E6/m9fdIUQXKUHI1pn95E9lSSXQJODs=";
  };
  meta.homepage = "https://github.com/vxpm/rust-expand-macro.nvim";
  meta.hydraPlatforms = [ ];
}
