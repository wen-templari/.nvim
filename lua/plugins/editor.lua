return {

  { 'tpope/vim-repeat' },
  {
    'mg979/vim-visual-multi',
    branch = 'master',
    event = { "BufReadPost", "BufNewFile" }
  },
  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        delay = 500,
      })
    end
  },
  { 'dkarter/bullets.vim' },
  {
    'windwp/nvim-autopairs',
    event = { "InsertEnter" },
    opts = {} -- this is equalent to setup({}) function
  },
  {
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure({
        providers = {
          'regex',
        },
      })
    end
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true,           -- #RGB hex codes
        RRGGBB = true,        -- #RRGGBB hex codes
        names = true,         -- "Name" codes like Blue or blue
        RRGGBBAA = false,     -- #RRGGBBAA hex codes
        AARRGGBB = true,      -- 0xAARRGGBB hex codes
        rgb_fn = false,       -- CSS rgb() and rgba() functions
        hsl_fn = false,       -- CSS hsl() and hsla() functions
        css = false,          -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false,       -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "virtualtext", -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = true,
        sass = { enable = false },
        virtualtext = "■",
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {},
    }
  },
  {
    "pocco81/auto-save.nvim",
    event = { "InsertEnter" },
    config = function()
      require("auto-save").setup()
    end
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          chars = {
            horizontal_line = "",
            vertical_line = "│",
            left_top = "│",
            left_bottom = "│",
            right_arrow = "",
          },
        },
        indent = {
          chars = {
            "│",
          },
        },
        blank = {
          chars = {
            " ",
          },
        }
      })
    end
  },
  {
    'tpope/vim-surround',
    event = { "InsertEnter" },
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-`>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = 'float',
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = 'curved',
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          }
        }
      })
    end
  },
  {
    'famiu/bufdelete.nvim',
    config = function()
      -- This plugin provides better buffer deletion
    end
  }
}
