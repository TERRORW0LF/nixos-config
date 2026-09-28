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
    rev = "df7c10775e3875f2ec653f4e37884b404ce85452";
    hash = "sha256-U6YagUGk/2wMtIDlrVzW14Ojmv+4N5frCcj+D3jo5Cs=";
  };
  meta.homepage = "https://github.com/vxpm/rust-expand-macro.nvim";
  meta.hydraPlatforms = [ ];
}
