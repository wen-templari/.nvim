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

require("lazy").setup({
  -- load theme first so that other plugin config can overwrite it
  require('plugins/theme'),
  require('plugins/editor'),
  require('plugins/project'),
  require('plugins/ui'),
  require('plugins/lsp'),
  require('plugins/nvim-treesitter'),
  require('plugins/git'),
  require('plugins/search'),

  -- { 'Bekaboo/dropbar.nvim' },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' }
    }
  },
  { 'github/copilot.vim' },
})

require('plugins/theme_persist')
require('shortcuts')
