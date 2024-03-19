vim.g.mapleader = " "

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.number = true
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', { silent = true })

vim.api.nvim_set_keymap('n', '<Space>e', '<Cmd>CocCommand explorer<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>qf', '<Plug>(coc-fix-current)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', ':lua show_documentation()<CR>', { noremap = true, silent = true })

vim.g.copilot_filetypes = { ['*'] = true }
vim.cmd('autocmd bufnewfile,bufread *.yml set filetype=yaml')

function show_documentation()
  local filetype = vim.bo.filetype
  local keywordprg = vim.bo.keywordprg
  local cword = vim.fn.expand('<cword>')

  if vim.tbl_contains({ 'vim', 'help' }, filetype) then
    vim.cmd('h ' .. cword)
  elseif vim.fn['coc#rpc#ready']() then
    vim.fn.CocActionAsync('doHover')
  else
    vim.fn.system(keywordprg .. ' ' .. cword)
  end
end

-- plugins
local plugins = {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'neoclide/coc.nvim',
    branch = "release",
  },
  {
    'rust-lang/rust.vim',
  },
  {
    'github/copilot.vim',
    filetypes = { '*' },
  },
  {
    'nvim-lua/plenary.nvim',
  },
  {
    'nvim-telescope/telescope.nvim',
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = "all",
        auto_install = true,
        indent = {
          enable = true,
        },
        highlight = {
          enable = false,
        },
      }
    end,
  },
  {
    'nvim-treesitter/playground',
    config = function()
      require('nvim-treesitter.configs').setup {
        playground = {
          enable = true,
          disable = {},
          updatetime = 25,
          persist_queries = false,
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          }
        }
      }
    end,
  },
  {
    'jiangmiao/auto-pairs',
  },
  {
    'akinsho/bufferline.nvim',
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
  {
    "folke/zen-mode.nvim",
    opts = {}
  },
  {
    "lambdalisue/reword.vim",
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    'tpope/vim-rails'
  },
  {
    'tpope/vim-endwise'
  },
  {
    'tpope/vim-surround'
  },
  {
    'thoughtbot/vim-rspec'
  },
  {
    'cespare/vim-toml',
  },
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

vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', { silent = true })
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', { silent = true })


-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- bufferline
require 'bufferline'.setup({
  options = {
    -- mode = "tabs",
    -- separator_style = 'thick',
    -- separator_style = 'slant',
    -- always_show_bufferline = false,
    -- show_buffer_close_icons = true,
    -- show_close_icon = true,
    -- color_icons = true,
  },
  highlights = {
    separator = {
      fg = '#073642',
      bg = '#000000',

    },
    background = {
      fg = '#657b83',
      bg = '#444444'

    },
    buffer_selected = {
      fg = '#ffffff',
      bg = '#000000',
      bold = true,

    },
    fill = {
      bg = '#073642'

    }
  },
})

vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})

vim.cmd [[colorscheme tokyonight]]
vim.opt.background = 'dark'
