{ pkgs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  extensions =
    (import (
      builtins.fetchGit {
        url = "https://github.com/nix-community/nix-vscode-extensions";
        rev = "3c9c62e3505bcb2331f2e36d19dfea4a74d4d962";
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
