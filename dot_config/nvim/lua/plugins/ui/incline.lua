---@module 'lazy'
---@type LazySpec
return {
  'b0o/incline.nvim',
  opts = {
    highlight = {
      groups = {
        InclineNormal = { guibg = '#1b211d', guifg = '#dfe4dd' },
        InclineNormalNC = { guibg = '#0f1511', guifg = '#8a938b' },
      },
    },
    window = {
      overlap = {
        borders = true,
      },
    },
    render = function(props)
      local icons = require 'mini.icons'
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
      if filename == '' then
        filename = '[No Name]'
      end
      local ft_icon, ft_hl = icons.get('filetype', vim.bo[props.buf].ft)
      local ft_color_num = ft_hl and vim.api.nvim_get_hl(0, { name = ft_hl, link = false }).fg
      local ft_color = ft_color_num and string.format('#%06x', ft_color_num)

      local function get_hl_color(name)
        local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
        return hl.fg and string.format('#%06x', hl.fg)
      end

      local function get_git_diff()
        local git_icons = {
          removed = { icon = ' ', hl = 'GitSignsDelete' },
          changed = { icon = ' ', hl = 'GitSignsChange' },
          added = { icon = ' ', hl = 'GitSignsAdd' },
        }
        local signs = vim.b[props.buf].gitsigns_status_dict
        local labels = {}
        if signs == nil then
          return labels
        end
        for name, data in pairs(git_icons) do
          if tonumber(signs[name]) and signs[name] > 0 then
            table.insert(labels, { data.icon .. signs[name] .. ' ', guifg = get_hl_color(data.hl) })
          end
        end
        if #labels > 0 then
          table.insert(labels, { '┊ ' })
        end
        return labels
      end

      local function get_diagnostic_label()
        local diag_icons = {
          { key = 'error', icon = ' ', hl = 'DiagnosticSignError' },
          { key = 'warn', icon = ' ', hl = 'DiagnosticSignWarn' },
          { key = 'info', icon = ' ', hl = 'DiagnosticSignInfo' },
          { key = 'hint', icon = ' ', hl = 'DiagnosticSignHint' },
        }
        local label = {}

        for _, data in ipairs(diag_icons) do
          local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(data.key)] })
          if n > 0 then
            table.insert(label, { data.icon .. n .. ' ', guifg = get_hl_color(data.hl) })
          end
        end
        if #label > 0 then
          table.insert(label, { '┊ ' })
        end
        return label
      end

      local function get_modified_indicator()
        if vim.bo[props.buf].modified then
          return { '  ', group = 'DiagnosticError' }
        elseif vim.bo[props.buf].modifiable == false or vim.bo[props.buf].readonly then
          return { '  ', group = 'DiagnosticWarn' }
        end
        return { ' ' }
      end

      return {
        { get_diagnostic_label() },
        { get_git_diff() },
        { (ft_icon or ' ') .. ' ', guifg = ft_color, guibg = 'none' },
        { filename, gui = vim.bo[props.buf].modified and 'bold,italic' or 'bold' },
        get_modified_indicator(),
        { '┊  ' .. vim.api.nvim_win_get_number(props.win), group = 'MiniIconsGrey' },
      }
    end,
  },
  event = 'VeryLazy',
}
