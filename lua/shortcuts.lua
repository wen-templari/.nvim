vim.g.mapleader = " "
local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

map('n', '<leader>ff', ':Telescope find_files<CR>', opt)
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
