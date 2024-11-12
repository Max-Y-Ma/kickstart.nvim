-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Plugin to help with fetching commonly used files
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
      local harpoon = require 'harpoon'

      -- REQUIRED
      harpoon:setup()
      -- REQUIRED

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end)
      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set('n', '<leader>1', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<leader>2', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<leader>3', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<leader>4', function()
        harpoon:list():select(4)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<C-p>', function()
        harpoon:list():prev()
      end)
      vim.keymap.set('n', '<C-n>', function()
        harpoon:list():next()
      end)
    end,
  },
  -- Plugin to help comment out code quickly
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    config = function()
      require('Comment').setup()
    end,
  },
  -- Plugin to automatically toggle line numbers in normal and insert mode
  {
    'sitiom/nvim-numbertoggle',
  },
  -- Plugin to display LSP diagnostics elegantly
  {
    {
      'rachartier/tiny-inline-diagnostic.nvim',
      event = 'LspAttach',
      config = function()
        require('tiny-inline-diagnostic').setup()
      end,
    },
  },
  -- Plugin to toggle a floating terminal
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {},
    config = function()
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new {
        cmd = 'lazygit',
        dir = 'git_dir',
        direction = 'float',
        float_opts = {
          border = 'double',
        },
        -- function to run on opening the terminal
        on_open = function(term)
          vim.cmd 'startinsert!'
          vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
        end,
        -- function to run on closing the terminal
        on_close = function(term)
          vim.cmd 'startinsert!'
        end,
      }

      function _lazygit_toggle()
        lazygit:toggle()
      end

      local terminal = Terminal:new {
        cmd = 'ssh -CY maxma@sccf06223107.zsc12.intel.com',
        direction = 'float',
        float_opts = {
          boarder = 'double',
        },
        -- function to run on opening the terminal
        on_open = function(term)
          vim.cmd 'startinsert!'
          vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
        end,
        -- function to run on closing the terminal
        on_close = function(term)
          vim.cmd 'startinsert!'
        end,
      }

      function _terminal_toggle()
        terminal:toggle()
      end

      local home = Terminal:new {
        dir = vim.fn.getcwd(),
        direction = 'float',
        float_opts = {
          border = 'double',
        },
        -- function to run on opening the terminal
        on_open = function(term)
          vim.cmd 'startinsert!'
          vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
        end,
        -- function to run on closing the terminal
        on_close = function(term)
          vim.cmd 'startinsert!'
        end,
      }

      function _home_toggle()
        home:toggle()
      end

      vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>lua _terminal_toggle()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>h', '<cmd>lua _home_toggle()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })
      require('toggleterm').setup()
    end,
  },
  {
    'mg979/vim-visual-multi',
    config = function()
      vim.cmd [[
        nmap   <C-LeftMouse>         <Plug>(VM-Mouse-Cursor)
        nmap   <C-RightMouse>        <Plug>(VM-Mouse-Word)
        nmap   <M-C-RightMouse>      <Plug>(VM-Mouse-Column)
      ]]
    end,
  },
}
