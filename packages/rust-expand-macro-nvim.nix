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
    rev = "71536e492351b6ef049de022541985b8b159e4f5";
    hash = "sha256-T7wzziTElK7WmeDF49J9h6BPUJ8QijYVaL4i8vHmOu8=";
  };
  meta.homepage = "https://github.com/vxpm/rust-expand-macro.nvim";
  meta.hydraPlatforms = [ ];
}
