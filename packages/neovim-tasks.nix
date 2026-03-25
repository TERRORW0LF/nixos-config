{
  buildVimPlugin,
  fetchFromGitHub,
  vimPlugins,
}:
buildVimPlugin {
  pname = "neovim-tasks";
  version = "0-unstable-03-03-2026";
  src = fetchFromGitHub {
    #owner = "Shatur";
    repo = "neovim-tasks";
    #rev = "8c2bafe4863c624c23067f91d1498696c14837ae";
    #hash = "sha256-gEQCzGJLZnHKSrgC25TwK3X0l0InZw2VhsefcdZmEDU=";
    owner = "TERRORW0LF";
    rev = "5ee611ce5209d1dfde8ab114020a8a180f5f0d7e";
    hash = "sha256-/Myc6JxCnvBMh9/iSdq9BhgM+/uWISXOF3wj5n2mM3U=";
  };
  dependencies = with vimPlugins; [ plenary-nvim ];
  meta.homepage = "https://github.com/Shatur/neovim-tasks";
  meta.hydraPlatforms = [ ];
}
