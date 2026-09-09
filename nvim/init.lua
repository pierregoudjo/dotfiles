-- Pierre's Simple Neovim configuration

-- Remove useless providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
-- Packages download
vim.pack.add {
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/nvim-mini/mini.nvim' },
  { src = 'https://github.com/mcncl/alabaster.nvim' },
  { src = 'https://github.com/stevearc/oil.nvim.git' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/bullets-vim/bullets.vim' },
  { src = 'https://github.com/tadmccorkle/markdown.nvim' },
  { src = 'https://github.com/folke/zen-mode.nvim' },
  { src = 'https://github.com/alex35mil/pi.nvim' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/tpope/vim-sleuth.git' },
  { src = 'https://github.com/stevearc/conform.nvim.git' },
  { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
}

-- Package setup
require('mini.ai').setup()
require('mini.icons').setup()
require('mini.pairs').setup()
require('mini.snippets').setup()
require('mini.pick').setup()
require('mini.extra').setup()
require('mini.completion').setup {
  fallback_action = '',
}
require('mini.align').setup()
require('mini.notify').setup()
require('mini.basics').setup()
require('mini.diff').setup {
  view = {
    style = 'sign',
    signs = {
      add = '+',
      change = '~',
      delete = '-',
    },
  },
}
require('mini.git').setup()
require('mini.surround').setup()
require('markdown').setup()
local miniclue = require 'mini.clue'
miniclue.setup {
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
}

--Tree-sitter configuration
local languages = { 'lua', 'terraform', 'javascript', 'clojure', 'typescript', 'markdown' }
require('nvim-treesitter').install(languages)

vim.api.nvim_create_autocmd('FileType', {
  pattern = languages,
  callback = function()
    vim.treesitter.start()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldmethod = 'expr'
  end,
})
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
    end
  end,
})
vim.treesitter.language.register('clojure', { 'edn', 'clojure' })
vim.treesitter.language.register('terraform', { 'terraform', 'terraform-vars' })

require('mason').setup {
  ensure_installed = {
    'stylua',
  },
}
require('mason-tool-installer').setup {
  ensure_installed = {
    'lua_ls',
    'markdown_oxide',
    'clojure_lsp',
    'terraformls',
    'ts_ls',
    'stylua',
  },
  automatic_enable = true,
}

vim.lsp.enable {
  'lua_ls',
  'markdown_oxide',
  'clojure_lsp',
  'terraformls',
  'ts_ls',
}
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {
          'vim',
        },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
    },
  },
})
--
-- Merge capabilities with the default config from lsp/markdown_oxide.lua
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Use the function call form to MERGE (not replace) the config
vim.lsp.config('markdown_oxide', {
  -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
  -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
  capabilities = vim.tbl_deep_extend('force', capabilities, {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  }),
})

require('oil').setup()

require('pi').setup()

require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
  },
}

-- Global options
vim.cmd.colorscheme 'alabaster'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.scrolloff = 10
vim.opt.confirm = true
vim.opt.mouse = ''
vim.opt.foldlevelstart = 99




-- Keymaps
-- stylua: ignore start
vim.keymap.set('n', '<Esc>'           , '<cmd>nohlsearch<CR>'                         , {desc = 'Disable Highlighting'})
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
vim.keymap.set('n', '<leader>nl'      , MiniNotify.show_history, {desc = '[N]otification [L]ist'})
vim.keymap.set('n', '<leader><leader>', MiniPick.builtin.buffers                      , {desc = '[ ] Find existing buffers'})
-- stylua: ignore end
-- Highlight the cursor line in MiniPick because the colorscheme blurs it
vim.api.nvim_set_hl(0, 'MiniPickMatchCurrent', { bg = '#98fb98' })

-- Custom Commands
vim.api.nvim_create_user_command('Format', function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end
  require('conform').format { async = true, lsp_format = 'fallback', range = range }
end, { range = true })
