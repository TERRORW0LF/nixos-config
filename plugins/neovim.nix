{ pkgs }:
with pkgs.vimPlugins;
[
  auto-session
  direnv-nvim
  nvim-treesitter.withAllGrammars
  nvim-lspconfig
  nvim-dap
  nvim-dap-virtual-text
  neovim-tasks
  flutter-tools-nvim
  nvim-cmp
  cmp-nvim-lsp
  cmp-nvim-lsp-signature-help
  luasnip
  telescope-nvim
  telescope-fzf-native-nvim
  toggleterm-nvim
  lualine-nvim
  virt-column-nvim
  better-escape-nvim
  onedarkpro-nvim
]
