return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'mason-org/mason.nvim' },           -- Optional
      { 'mason-org/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' }, -- Required
      { 'L3MON4D3/LuaSnip' }, -- Required
      { 'onsails/lspkind.nvim' },

      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-calc",
      "f3fora/cmp-spell"
    },
    config = function()
      local lsp = require('lsp-zero').preset({})

      lsp.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp.default_keymaps({ buffer = bufnr })
      end)
      lsp.setup()

      require('mason-lspconfig').setup {
        ensure_installed = { "lua_ls", "gopls" },
      }
      require("mason-lspconfig").setup_handlers {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {}
        end,

        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup {
            settings = {
              Lua = {
                runtime = {
                  version = 'LuaJIT',
                },
                diagnostics = {
                  globals = { 'vim' },
                },
                workspace = {
                  -- Make the server aware of Neovim runtime files
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = false
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                  enable = false,
                },
              }
            }
          }
        end,

        ["gopls"] = function()
          require("lspconfig").gopls.setup {
            settings = {
              semanticTokens = true
            }
          }
        end,

      }
      vim.opt.spell = true
      vim.opt.spelllang = { 'en_us' }
      local cmp = require('cmp')
      -- local lspkind = require('lspkind')
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          -- ['<Esc>'] = cmp.mapping.abort(),
          ['<Esc>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.abort()
              vim.api.nvim_input("<esc>")
            else
              fallback()
            end
          end),
          ['<Space>'] = cmp.mapping.confirm({ select = false }),
          -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp', max_item_count = 10 },
          {
            name = 'spell',
            option = {
              keep_all_entries = false,
              enable_in_context = function()
                return true
              end,
            },
          },
          { name = 'buffer' },
        }, {
          { name = "path" },
          { name = "nvim_lua" },
          { name = "calc" },
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({
              mode = "symbol_text",
              width = 60
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = strings[1] or ""
            -- kind.menu = "    (" .. (strings[2] or "") .. ")"
            return kind
          end,
        },
        -- formatting = {
        --   format = lspkind.cmp_format({
        --     mode = "symbol_text",
        --   })
        -- }
      })
      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = 'buffer' },
        })
      })
    end

  }
}
