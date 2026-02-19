{ ... }:

{
  imports = [
    # Core config

    # Completion
    ./plugins/cmp/blink-cmp.nix
    ./plugins/cmp/luasnip.nix

    # LSP
    ./plugins/lsp/nix.nix
    ./plugins/lsp/python.nix
    ./plugins/lsp/rust.nix
    ./plugins/lsp/typst.nix
  ];
}
