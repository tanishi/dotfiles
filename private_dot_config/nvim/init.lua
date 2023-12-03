vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.number = true
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', {silent=true})

vim.api.nvim_set_keymap('n', '<Space>e', '<Cmd>CocCommand explorer<CR>', { noremap = true, silent = true })

-- plugins
local plugins = {
  {
    'neoclide/coc.nvim',
    branch = "release",
  },
  {
    'rust-lang/rust.vim',
  },
  {
    'github/copilot.vim',
  }
}

-- lazy start
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(plugins, opts)

vim.g.rustfmt_autosave = 1
