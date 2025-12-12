---@module 'lazy'
---@type LazySpec
return {
  'b0o/incline.nvim',
  opts = {
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

      local function get_git_diff()
        local icons = { removed = ' ', changed = ' ', added = ' ' }
        local signs = vim.b[props.buf].gitsigns_status_dict
        local labels = {}
        if signs == nil then
          return labels
        end
        for name, icon in pairs(icons) do
          if tonumber(signs[name]) and signs[name] > 0 then
            table.insert(labels, { icon .. signs[name] .. ' ', group = 'Diff' .. name })
          end
        end
        if #labels > 0 then
          table.insert(labels, { '┊ ' })
        end
        -- dd(labels)
        return labels
      end

      local function get_diagnostic_label()
        local icons = { error = ' ', warn = ' ', info = ' ', hint = ' ' }
        local label = {}

        for severity, icon in pairs(icons) do
          local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
          if n > 0 then
            table.insert(label, { icon .. n .. ' ', group = 'DiagnosticSign' .. severity })
          end
        end
        if #label > 0 then
          table.insert(label, { '┊ ' })
        end
        return label
      end

      local function get_modified_indicator()
        if vim.bo[props.buf].modified then
          return { '  ', guifg = '#ec5f67', gui = 'bold' }
        elseif vim.bo[props.buf].modifiable == false or vim.bo[props.buf].readonly then
          return { '  ', guifg = '#FF8800', gui = 'bold' }
        end
        return { ' ' }
      end

      return {
        { get_diagnostic_label() },
        { get_git_diff() },
        { (ft_icon or ' ') .. ' ', guifg = ft_color, guibg = 'none' },
        { filename, gui = vim.bo[props.buf].modified and 'bold,italic' or 'bold' },
        get_modified_indicator(),
        { '┊  ' .. vim.api.nvim_win_get_number(props.win), group = 'MiniIconsGrey' },
      }
    end,
  },
  event = 'VeryLazy',
}
