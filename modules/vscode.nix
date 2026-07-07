{ pkgs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  extensions =
    (import (
      builtins.fetchGit {
        url = "https://github.com/nix-community/nix-vscode-extensions";
        rev = "8b186aaef70c2fc386ccdaaa513940cb1124e75a";
      }
    )).extensions.${system};
  extensionsList =
    with extensions.vscode-marketplace-release;
    [
      mkhl.direnv
      gitlab.gitlab-workflow
      jnoortheen.nix-ide
      ms-python.python
      ms-toolsai.jupyter
      rust-lang.rust-analyzer
      llvm-vs-code-extensions.vscode-clangd
      ms-vscode.cmake-tools
      dart-code.flutter
      dart-code.dart-code
      oracle.oracle-java
      myriad-dreamin.tinymist
      zezombye.overpy
      pkief.material-icon-theme
      eamodio.gitlens
      ms-vscode.hexeditor
    ]
    ++ [
      # For extensions that don't work with nix-vscode-extensions
      pkgs.vscode-extensions.vadimcn.vscode-lldb
    ];
in
pkgs.vscode-with-extensions.override {
  vscode = pkgs.vscodium;
  vscodeExtensions = extensionsList;
}
