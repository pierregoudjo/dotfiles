-- Pierre's Simple Neovim configuration

-- Packages download
vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/mcncl/alabaster.nvim',
  'https://github.com/stevearc/oil.nvim.git'
})

-- Package setup
require('mini.icons').setup()
require('mini.pairs').setup()
require('mini.snippets').setup()
require('mini.statusline').setup()
require('mini.tabline').setup()
require('mini.pick').setup()
require('mini.extra').setup()
require('mini.completion').setup()
require('mini.align').setup()
require('mini.notify').setup()
require('mini.basics').setup()
require('mini.diff').setup()
require('mini.git').setup()
local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = { 'n', 'x' }, keys = '<Leader>' },

    -- `[` and `]` keys
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = { 'n', 'x' }, keys = 'g' },

    -- Marks
    { mode = { 'n', 'x' }, keys = "'" },
    { mode = { 'n', 'x' }, keys = '`' },

    -- Registers
    { mode = { 'n', 'x' }, keys = '"' },
    { mode = { 'i', 'c' }, keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = { 'n', 'x' }, keys = 'z' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})
require('oil').setup()

-- Global options
vim.cmd.colorscheme 'alabaster'
vim.o.number         = true
vim.o.relativenumber = true
vim.o.list           = true
vim.opt.listchars    = { tab = '» ', trail = '·', nbsp='␣' }
vim.o.inccommand     = 'split'
vim.o.scrolloff      = 10
vim.o.confirm        = true
vim.o.mouse          = ''

-- Lsp configuration
vim.lsp.config('lua_ls', {
  cmd = {'lua-language-server'},
  filetypes = {'lua'},
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
	globals = {
		'vim'
	}
      },
      workspace = {
	      library = vim.api.nvim_get_runtime_file("", true)
      }
    }
  }
})

-- Keymaps
vim.keymap.set('n', '<Esc>'           , '<cmd>nohlsearch<CR>'                         , {desc = 'Disable Higlighting'})
vim.keymap.set('t', '<Esc><Esc>'      , '<C-\\><C-n>'                                 , { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<left>'          , '<cmd>echo "Use h to move!!"<CR>'             , {desc = 'Disable arrow keys'})
vim.keymap.set('n', '<right>'         , '<cmd>echo "Use l to move!!"<CR>'             , {desc = 'Disable arrow keys'})
vim.keymap.set('n', '<up>'            , '<cmd>echo "Use k to move!!"<CR>'             , {desc = 'Disable arrow keys'})
vim.keymap.set('n', '<down>'          , '<cmd>echo "Use j to move!!"<CR>'             , {desc = 'Disable arrow keys'})
vim.keymap.set('n', '<leader>sf'      , MiniPick.builtin.files                        , {desc = '[S]earch [F]iles'})
vim.keymap.set('n', '<leader>sg'      , MiniPick.builtin.grep_live                    , {desc = '[S]earch by [G]rep'})
vim.keymap.set('n', '<leader>sh'      , '<Cmd>Pick help default_split="vertical"<CR>' , {desc = '[S]earch [H]elp'})
vim.keymap.set('n', '<leader>sk'      , '<Cmd>Pick keymaps<CR>'                       , {desc = '[S]earch [K]eymaps'})
vim.keymap.set('n', '<leader>sd'      , '<Cmd>Pick diagnostic<CR>'                    , {desc = '[S]earch [D]iagnostic'})
vim.keymap.set('n', '<leader>sr'      , MiniPick.builtin.resume                       , {desc = '[S]earch [R]esume'})
vim.keymap.set('n', '<leader>gd'      , '<Cmd>Pick lsp scope="definition"<CR>'        , {desc = '[G]o to [D]efinition'})

-- Higlight the cursor line in MiniPick because the colorscheme blurs it
vim.api.nvim_set_hl(0, 'MiniPickMatchCurrent', {bg = '#98fb98'})
vim.keymap.set('n', '<leader><leader>', MiniPick.builtin.buffers                      , {desc = '[ ] Find existing buffers'})
