local colors = {
  darkgray = '#555555',
  green = '#83ff98',
  yellow = '#ecce7b',
  red = '#ec5f67',
  orange = '#FF8800',
  blue = '#51afef',
  magenta = '#c678dd',
}

vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
vim.api.nvim_set_hl(0, 'StatuslineFilename', { bg = colors.darkgray, fg = '#FFFFFF' })
vim.api.nvim_set_hl(0, 'StatuslineProjectName', { bg = '#383a42', fg = '#FFFFFF' })

local function general()
  vim.api.nvim_set_hl(0, 'WinSeparator', { link = 'FloatBorder' })
end
-- Gitsigns
local function gitsigns()
  vim.api.nvim_set_hl(0, 'StatuslineDiffAdd', { fg = colors.green, bg = colors.darkgray })
  vim.api.nvim_set_hl(0, 'StatuslineDiffChange', { fg = colors.yellow, bg = colors.darkgray })
  vim.api.nvim_set_hl(0, 'StatuslineDiffDelete', { fg = colors.red, bg = colors.darkgray })

  vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = colors.green })
  vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = colors.yellow })
  vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = colors.red })

  -- Incline
  vim.api.nvim_set_hl(0, 'Diffadded', { fg = colors.green })
  vim.api.nvim_set_hl(0, 'Diffchanged', { fg = colors.yellow })
  vim.api.nvim_set_hl(0, 'Diffremoved', { fg = colors.red })
  vim.api.nvim_set_hl(0, 'DiagnosticSignerror', { fg = colors.red })
  vim.api.nvim_set_hl(0, 'DiagnosticSignwarn', { fg = colors.orange })
  vim.api.nvim_set_hl(0, 'DiagnosticSigninfo', { fg = colors.blue })
  vim.api.nvim_set_hl(0, 'DiagnosticSignhint', { fg = colors.magenta })
end

return {
  gitsigns = gitsigns,
  general = general,
}
