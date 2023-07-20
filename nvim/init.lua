vim.cmd('set number')               -- Enable Number-Row
vim.opt.termguicolors = true        -- Enable Termguicolors

-- Imports
require('plugins')                  -- Import Plugins
require('keys')                     -- Import Keybindings
require('aliases')                  -- Import Command-Aliases

vim.cmd.colorscheme "ghdark"        -- Set Colorscheme

-- Set indent to 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
