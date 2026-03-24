-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "zivyangll/git-blame.vim",
  "dense-analysis/ale",
  "pacha/vem-tabline",
  "vim-airline/vim-airline",
  "gmoe/vim-espresso",
  "vim-python/python-syntax",

  -- LSP
  "neovim/nvim-lspconfig",

  -- Completion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  { "L3MON4D3/LuaSnip", version = "v2.*" },
  "saadparwaiz1/cmp_luasnip",
})

------------------------------------------------------------
-- General settings
------------------------------------------------------------
vim.opt.fileformat   = "unix"
vim.opt.fileformats  = { "unix", "dos" }
vim.opt.clipboard    = "unnamedplus"

vim.opt.background   = "dark"
-- vim.cmd("colorscheme espresso")

vim.opt.hidden       = true
vim.opt.wildmenu     = true
vim.opt.showcmd      = true
vim.opt.number       = true
vim.opt.ruler        = true
vim.opt.laststatus   = 2
vim.opt.cmdheight    = 2
vim.opt.confirm      = true
vim.opt.visualbell   = true
vim.opt.mouse        = "a"

vim.opt.syntax       = "on"
vim.cmd("filetype plugin indent on")

------------------------------------------------------------
-- Search
------------------------------------------------------------
vim.opt.hlsearch   = true
vim.opt.ignorecase = true
vim.opt.smartcase  = true

------------------------------------------------------------
-- Editing
------------------------------------------------------------
vim.opt.backspace    = { "indent", "eol", "start" }
vim.opt.autoindent   = true
vim.opt.startofline  = false
vim.opt.shiftwidth   = 4
vim.opt.softtabstop  = 4
vim.opt.expandtab    = true

------------------------------------------------------------
-- Timing
------------------------------------------------------------
vim.opt.timeout      = false
vim.opt.ttimeout     = true
vim.opt.ttimeoutlen  = 200

------------------------------------------------------------
-- Keymaps
------------------------------------------------------------
-- ALE: navigate diagnostics
vim.keymap.set("n", "<C-k>", "<Plug>(ale_previous_wrap)", { silent = true })
vim.keymap.set("n", "<C-j>", "<Plug>(ale_next_wrap)",     { silent = true })

-- Git blame
vim.keymap.set("n", "<Leader>s", ":<C-u>call gitblame#echo()<CR>")

-- Buffer navigation
vim.keymap.set("n", "<C-N>", ":bnext<CR>")
vim.keymap.set("n", "<C-P>", ":bprev<CR>")

-- Y: yank to end of line (consistent with D and C)
vim.keymap.set("", "Y", "y$")

-- C-L: clear search highlight
vim.keymap.set("n", "<C-L>", ":nohl<CR><C-L>")

------------------------------------------------------------
-- Plugin settings
------------------------------------------------------------
-- ALE (linting/fixing — LSP handles completions now)
vim.g.ale_linters = {
  python     = { "ruff", "mypy" },
  sh         = { "shellcheck" },
  javascript = { "eslint" },
}
vim.g.ale_fixers = {
  ["*"]      = { "trim_whitespace" },
  python     = { "ruff", "ruff_format" },
  javascript = { "eslint", "prettier" },
  css        = { "prettier" },
  cpp        = { "clang-format" },
}
vim.g.ale_fix_on_save  = 1
vim.g.ale_echo_cursor  = 0
-- Disable ALE's own LSP to avoid conflicts with nvim-lspconfig
vim.g.ale_disable_lsp  = 1

-- Python syntax
vim.g.python_highlight_all = 1

-- Airline: show buffers in tabline
vim.g["airline#extensions#tabline#enabled"] = 1

------------------------------------------------------------
-- LSP
------------------------------------------------------------
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Python: pyright for completions, go-to-def, hover
-- Install with: pip install pyright
lspconfig.pyright.setup({ capabilities = capabilities })

-- Keymaps active only when an LSP is attached to the buffer
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }
    vim.keymap.set("n", "gd",         vim.lsp.buf.definition,     opts)
    vim.keymap.set("n", "K",          vim.lsp.buf.hover,          opts)
    vim.keymap.set("n", "gi",         vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename,         opts)
    vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action,    opts)
    vim.keymap.set("n", "gr",         vim.lsp.buf.references,     opts)
  end,
})

------------------------------------------------------------
-- Completion (nvim-cmp)
------------------------------------------------------------
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
    ["<Tab>"]     = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
      else fallback() end
    end, { "i", "s" }),
    ["<S-Tab>"]   = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then luasnip.jump(-1)
      else fallback() end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
})
