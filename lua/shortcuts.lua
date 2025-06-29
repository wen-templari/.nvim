vim.g.mapleader = " "
local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

-- VSCode-like shortcuts
map('n', '<C-p>', ':Telescope find_files<CR>', opt)                  -- Quick Open (Ctrl+P)
map('n', '<C-S-p>', ':Telescope commands<CR>', opt)                  -- Command Palette (Ctrl+Shift+P)
-- map('n', '<C-S-f>', ':Telescope live_grep<CR>', opt)
map('n', '<C-S-e>', ':NvimTreeToggle<CR>', opt)                      -- Toggle Explorer (Ctrl+Shift+E)
map('n', '<C-`>', ':ToggleTerm size=80 direction=vertical<CR>', opt) -- Toggle Terminal (Ctrl+`)
map('t', '<C-`>', '<C-\\><C-n>:ToggleTerm<CR>', opt)                 -- Toggle Terminal from terminal mode
map('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opt) -- Rename Symbol (F2)

map('n', '<C-b>', ':NvimTreeToggle<CR>', opt)

-- Additional VSCode-like shortcuts
-- map('n', '<C-S-f>', ':lua require("spectre").toggle()<CR>', opt) -- Find and Replace (Ctrl+Shift+F)
map('n', '<C-S-x>', ':TroubleToggle<CR>', opt)                   -- Problems Panel (Ctrl+Shift+X)
map('n', '<C-x>', ':bdelete<CR>', opt)                           -- Close Buffer/Tab (Ctrl+W)
map('n', '<C-S-t>', ':enew<CR>', opt)                            -- New Tab (Ctrl+Shift+T)

-- Buffer navigation (like tabs in VSCode)
map('n', '<C-Tab>', ':BufferLineCycleNext<CR>', opt)   -- Next Tab (Ctrl+Tab)
map('n', '<C-S-Tab>', ':BufferLineCyclePrev<CR>', opt) -- Previous Tab (Ctrl+Shift+Tab)
map('n', '<C-1>', ':BufferLineGoToBuffer 1<CR>', opt)  -- Go to Tab 1
map('n', '<C-2>', ':BufferLineGoToBuffer 2<CR>', opt)  -- Go to Tab 2
map('n', '<C-3>', ':BufferLineGoToBuffer 3<CR>', opt)  -- Go to Tab 3
map('n', '<C-4>', ':BufferLineGoToBuffer 4<CR>', opt)  -- Go to Tab 4
map('n', '<C-5>', ':BufferLineGoToBuffer 5<CR>', opt)  -- Go to Tab 5

-- Original shortcuts (keeping for compatibility)
map('n', '<leader>ff', ':Telescope find_files<CR>', opt)
map('n', '<leader>cp', ':Telescope commands<CR>', opt)                  -- Command Palette (Ctrl+Shift+P)
map('n', '<leader>fg', ':Telescope live_grep<CR>', opt)
map('n', '<leader>fh', ':Telescope help_tags<CR>', opt)

map('n', '<leader>tt', ':NvimTreeToggle<CR>', opt)
map('n', '<leader>tm', ':ToggleTerm size=80 direction=vertical<CR>', opt)
map('n', '<leader>tb', ':GitBlameToggle<CR>', opt)

map('n', '<leader>gf', '<cmd>lua=vim.lsp.buf.format()<CR>', opt)

map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
map('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opt)
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opt)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opt)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opt)

map('n', 'go', '<cmd>lua vim.diagnostic.open_float()<CR>', opt)
map('n', 'gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opt)
map('n', 'gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opt)

map('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opt)
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opt)
