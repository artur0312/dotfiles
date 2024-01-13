--Requires
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip/loaders/from_vscode").lazy_load({paths= "./my_snippets"})

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col,col):match "%s"
end

-- Nerd icons
local kind_icons = {
  Text = "󰦨",
  Method = "m",
  Function = "󰊕",
  Constructor = "",
  Field = "",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet
--

local luasnip = require('luasnip')

local unlinkgrp = vim.api.nvim_create_augroup(
  'UnlinkSnippetOnModeChange',
  { clear = true }
)

vim.api.nvim_create_autocmd('ModeChanged', {
  group = unlinkgrp,
  pattern = {'s:n', 'i:*'},
  desc = 'Forget the current snippet when leaving the insert mode',
  callback = function(evt)
    if
      luasnip.session
      and luasnip.session.current_nodes[evt.buf]
      and not luasnip.session.jump_active
    then
      luasnip.unlink_current()
    end
  end,
})
cmp.setup{
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) --For luasnip users
    end,
  },
  mapping = {
    -- Select completion from the preview list
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    -- Move in the documentation
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), {"i", "c"}),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), {"i", "c"}),
    -- Pull up the completions before typing
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
    --Disable defaut <C-y> mapping
    ["<C-y>"] = cmp.config.disable,
    --Abort selection
    ["<C-e>"] = cmp.mapping{
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Confirm selection
    ["<CR>"] = cmp.mapping.confirm {select = true},
    --["<TAB>"] = cmp.mapping.confirm {select = true},TAB

    -- Change tab according to context
    -- ['<Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif luasnip.expand_or_jumpable() then
    --     luasnip.expand_or_jump()
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }),
    --
    -- ["<S-Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif luasnip.jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end, {
    --     "i",
    --     "s",
    --   })
  },

  -- Formatting of the menu
  formatting = {
    fields = {"kind", "abbr", "menu"},
    format = function(entry, vim_item)
      --Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    {name = "nvim_lsp"},
    {name = "luasnip"},
    --{name = "buffer"},
    {name = "path"},
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
}

