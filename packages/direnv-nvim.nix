{
  buildVimPlugin,
  fetchFromGitHub,
}:
buildVimPlugin {
  pname = "direnv-nvim";
  version = "0-unstable-2025-02-10";
  src = fetchFromGitHub {
    owner = "NotAShelf";
    repo = "direnv.nvim";
    rev = "9e58bb5e8db19d8bf2626de8e94a85fc305a8c1e";
    hash = "sha256-TlQ3oTRirUf/Po1KWCL4wDp8GgrJXzYWQx0C5qyZFeQ=";
  };
  meta.homepage = "https://github.com/NotAShelf/direnv.nvim";
}
