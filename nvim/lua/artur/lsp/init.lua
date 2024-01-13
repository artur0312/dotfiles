local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "artur.lsp.mason"
require("artur.lsp.handlers").setup()
require "artur.lsp.null-ls"
