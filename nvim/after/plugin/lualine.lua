local ll = require("lualine")
ll.setup {
  options = {
    icons_enabled = true,
    -- theme = 'auto',
    theme = 'papercolor_dark',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = { 'neo-tree' },
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },

  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { 'buffers'},
    lualine_x = { 'selectioncount', 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress'},
    lualine_z = { 'location' }
  },

  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },

  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
