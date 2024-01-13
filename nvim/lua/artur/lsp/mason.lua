local servers = { "clangd" }

local settings = { ui = { border = "none", }, max_concurrent_installers = 4, }

require("mason").setup(settings) require("mason-lspconfig").setup({
  ensure_installed = servers, automatic_installation = true, })

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig") if not
  lspconfig_status_ok then return end

local opts = {}

for _, server in pairs(servers) do
  opts = { on_attach =require("artur.lsp.handlers").on_attach,
    capabilities = require("artur.lsp.handlers").capabilities, }
  server = vim.split(server,"@")[1]

  local require_ok, conf_opts = pcall(require, "artur.lsp.settings." ..
    server) if(require_ok) then opts = vim.tl_deep_extend("force", conf_opts,
    opts) end lspconfig[server].setup(opts) end

require("lspconfig").rust_analyzer.setup{}
