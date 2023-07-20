vim.keymap.set('i', '<S-Tab>', function () return vim.fn['codeium#Accept']() end, { expr = true })
vim.keymap.set('i', '<C-b>', function () return vim.fn['codeium#Complete']() end, { expr = true })
vim.keymap.set('i', '<C-n>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })