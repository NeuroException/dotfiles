local colors = {
    bg         = '#0d1117',
    grey       = '#161b22',
    accent     = '#cea5fb',
    white      = '#ecf2f8',
    red        = '#fa7970',
    violet     = '#cea5fb',
    orange     = '#faa356',
  }
  
  local bubbles_theme = {
    normal = {
      a = { fg = colors.bg, bg = colors.accent },
      b = { fg = colors.white, bg = colors.grey },
      c = { fg = colors.bg, bg = colors.bg },
    },
  
    insert = { a = { fg = colors.bg, bg = colors.violet } },
    visual = { a = { fg = colors.bg, bg = colors.red } },
    replace = { a = { fg = colors.bg, bg = colors.orange } },
  
    inactive = {
      a = { fg = colors.white, bg = colors.bg },
      b = { fg = colors.white, bg = colors.bg },
      c = { fg = colors.bg, bg = colors.bg },
    },
  }
  
  require('lualine').setup {
    options = {
      theme = bubbles_theme,
      component_separators = '|',
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = {
        { 'mode', separator = { left = '' }, right_padding = 2 },
      },
      lualine_b = { 'filename', 'branch' },
      lualine_c = { 'fileformat' },
      lualine_x = {},
      lualine_y = { 'filetype', 'progress' },
      lualine_z = {
        { 'location', separator = { right = '' }, left_padding = 2 },
      },
    },
    inactive_sections = {
      lualine_a = { 'filename' },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'location' },
    },
    tabline = {},
    extensions = {},
  }
