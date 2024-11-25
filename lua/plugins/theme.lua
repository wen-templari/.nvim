return {
  {
    "zaldih/themery.nvim",
    dependencies = {
      { "olimorris/onedarkpro.nvim" },
      {
        'wen-templari/nvim-quietlight',
        config = function()
          require('nvim-quietlight').setup({
            syntax = {
              booleans = { italic = false },
            }
          })
          vim.cmd('colorscheme quietlight')
          vim.cmd("highlight clear ColorColumn")
          vim.cmd("hi IlluminatedWordText guibg=#cecece gui=none")
        end
      },
    },
        config = function()
    require("themery").setup({
      themes = {
        {
          name = "Day",
          colorscheme = "quietlight",
        },
        {
          name = "Night",
          colorscheme = "onedark",
        }
      },
    })
      end
  }
}

-- Themery block
  -- This block will be replaced by Themery.
-- end themery block
