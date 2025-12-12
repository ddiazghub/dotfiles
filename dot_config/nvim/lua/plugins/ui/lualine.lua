---@module 'lazy'
---@type LazySpec
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-mini/mini.icons' },
  config = function()
    local colors = {
      black = '#383a42',
      white = '#f3f3f3',
      light_green = '#83ff98',
      darkgray = '#555555',
      gray = '#888888',
      light_gray = '#BBBBBB',
      yellow = '#ecce7b',
      cyan = '#00ffff',
      darkblue = '#081633',
      green = '#98be65',
      orange = '#FF8800',
      violet = '#a9a1e1',
      magenta = '#c678dd',
      blue = '#51afef',
      red = '#ec5f67',
    }

    local theme = {
      normal = {
        a = { fg = colors.black, bg = colors.blue, gui = 'bold' },
        b = { fg = colors.blue, bg = colors.darkgray, gui = 'bold' },
        c = { fg = colors.white, bg = colors.black, gui = 'bold' },
        z = { fg = colors.black, bg = colors.blue, gui = 'bold' },
      },
      insert = {
        a = { fg = colors.black, bg = colors.green, gui = 'bold' },
        b = { fg = colors.green, bg = colors.darkgray, gui = 'bold' },
      },
      visual = {
        a = { fg = colors.black, bg = colors.orange, gui = 'bold' },
        b = { fg = colors.orange, bg = colors.darkgray, gui = 'bold' },
      },
      command = {
        a = { fg = colors.black, bg = colors.violet, gui = 'bold' },
        b = { fg = colors.violet, bg = colors.darkgray, gui = 'bold' },
      },
      terminal = {
        a = { fg = colors.black, bg = colors.red, gui = 'bold' },
        b = { fg = colors.red, bg = colors.darkgray, gui = 'bold' },
      },
      replace = {
        a = { fg = colors.black, bg = colors.magenta, gui = 'bold' },
        b = { fg = colors.magenta, bg = colors.darkgray, gui = 'bold' },
      },
      select = {
        a = { fg = colors.black, bg = colors.cyan, gui = 'bold' },
        b = { fg = colors.cyan, bg = colors.darkgray, gui = 'bold' },
      },
    }

    local function get_mode()
      local mode_names = {
        n = 'normal',
        i = 'insert',
        v = 'visual',
        ['\22'] = 'visual',
        c = 'command',
        t = 'terminal',
        nt = 'terminal',
        r = 'replace',
        s = 'select',
        ['\19'] = 'select',
      }
      local mode = vim.api.nvim_get_mode().mode
      local first_char = mode:sub(1, 1):lower()
      return mode_names[mode] or mode_names[first_char]
    end

    local empty = require('lualine.component'):extend()
    function empty:draw(default_highlight)
      self.status = ''
      self.applied_separator = ''
      self:apply_highlights(default_highlight)
      self:apply_section_separators()
      return self.status
    end

    -- Put proper separators and gaps between components in sections
    local function process_sections(sections)
      for name, section in pairs(sections) do
        local left = name:sub(9, 10) < 'x'
        for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
          table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.black } })
        end
        for id, comp in ipairs(section) do
          if type(comp) ~= 'table' then
            comp = { comp }
            section[id] = comp
          end
          comp.separator = left and { right = '' } or { left = '' }
        end
      end
      return sections
    end

    local function search_result()
      local cword = vim.fn.expand '<cword>'
      if vim.v.hlsearch == 0 then
        return (cword and cword ~= '') and cword or '--'
      end
      local last_search = vim.fn.getreg '/'
      if not last_search or last_search == '' then
        return cword ~= '' and cword or '--'
      end
      local searchcount = vim.fn.searchcount { maxcount = 9999 }
      return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
    end

    local function modified()
      if vim.bo.modified then
        return '+'
      elseif vim.bo.modifiable == false or vim.bo.readonly == true then
        return '-'
      end
      return ''
    end

    require('lualine').setup {
      options = {
        theme = theme,
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
      sections = process_sections {

        lualine_a = {
          { 'mode' },
        },
        lualine_b = {
          {
            'branch',
            icon = '',
            fmt = function(branch)
              if branch == '' or branch == nil then
                return '󱓌 no repo'
              end
              return ' ' .. branch
            end,
          },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {
          { -- Search status or current word under cursor
            search_result,
            color = function()
              return { bg = theme[get_mode()].b.fg, fg = colors.black, gui = 'bold' }
            end,
          },
          { -- LSP Status
            function()
              local clients = vim.lsp.get_clients { bufnr = 0 }

              if next(clients) == nil then
                return '  No Active LSP'
              end

              local names = {}
              for _, client in ipairs(clients) do
                table.insert(names, client.name)
              end
              return '  ' .. table.concat(names, ', ')
            end,
            color = function()
              return { fg = theme[get_mode()].b.fg, bg = colors.darkgray, gui = 'bold' }
            end,
          },
        },
        lualine_z = {
          { -- Document Position
            function()
              return string.format('󰧮 %d/%d:%d', vim.fn.line '.', vim.fn.line '$', vim.fn.col '.')
            end,
            color = function()
              return { bg = colors.black, fg = theme[get_mode()].b.fg, gui = 'bold' }
            end,
          },
          '%p%%', -- Position %
        },
      },
      inactive_sections = {
        lualine_c = { '%f %y %m' },
        lualine_x = {},
      },
    }
  end,
}
