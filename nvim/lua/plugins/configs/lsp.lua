local lsp = require('lsp-zero').preset({
    name = 'recommended',
    set_lsp_keymaps = false,
    manage_nvim_cmp = true,
    suggest_lsp_servers = true,
    configure_diagnostics = false,
    float_border = 'double',
  })
  lsp.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
  })
  lsp.ensure_installed({
    'rust_analyzer',
    'clangd',
    'cmake',
    'pyright',
    'bashls',
    'html',
    'unocss',
    'tailwindcss'
  })
  lsp.nvim_workspace()
  lsp.setup()