---@alias PackSpec string | vim.pack.Spec

---@class PackAutocmdGroupEntry
---@field spec PackSpec[]
---@field setup fun()[]
---
---@class PackCmdStubGroupEntry
---@field spec PackSpec[]
---@field cmds string[]
---@field setup fun()

---@class PackAutocmdOpts
---@field event string
---@field pattern string
---@field setup? fun()

---@type PackSpec[]
local plugins = {}

---@type fun()[]
local setup = {}

---@type table<string, table<string, PackAutocmdGroupEntry>>
local autocmd_groups = {}

---@type table<string, PackCmdStubGroupEntry>
local cmd_stubs = {}

---@type { name: string, context: string, start: number, duration: number }[]
local load_times = {}

---Deduplicate plugin specs by source URL while preserving first occurrence.
---@param plugin_spec (string | vim.pack.Spec)[]
---@return (string | vim.pack.Spec)[]
local function dedupe(plugin_spec)
  local deduped = {}
  local seen = {}

  for _, spec in ipairs(plugin_spec) do
    local plugin = spec

    if type(spec) ~= 'string' then
      plugin = spec.src
    end

    if not seen[plugin] then
      seen[plugin] = true
      table.insert(deduped, spec)
    end
  end

  return deduped
end

---Group plugin specs that should be installed on the same autocmd trigger.
---@param spec (string | vim.pack.Spec)[]
---@param opts PackAutocmdOpts
local function group_by_autocmd(spec, opts)
  local autocmd_group = autocmd_groups[opts.event]

  if autocmd_group == nil then
    autocmd_group = {}
    autocmd_groups[opts.event] = autocmd_group
  end

  local group = autocmd_group[opts.pattern]

  if group == nil then
    group = { spec = {}, setup = {} }
    autocmd_group[opts.pattern] = group
  end

  vim.list_extend(group.spec, spec)

  if opts.setup then
    table.insert(group.setup, opts.setup)
  end
end

---Add plugin to be installed.
---@param spec (string | vim.pack.Spec)[]
---@param opts? { event?: string, pattern?: string, cmd?: string | string[], setup?: fun() }
local function add(spec, opts)
  opts = opts or {}

  if opts.cmd ~= nil then
    local plugin_name = spec[1]
    if type(spec[1]) ~= 'string' then
      plugin_name = spec[1].src
    end

    local stub = cmd_stubs[plugin_name]

    local cmds = type(opts.cmd) == 'string' and { opts.cmd } or opts.cmd

    if stub == nil then
      cmd_stubs[plugin_name] = {
        spec = spec,
        setup = opts.setup,
        cmds = cmds,
      }
    else
      vim.list_extend(stub.cmds, cmds)

      if opts.setup ~= nil then
        local original_setup = stub.setup

        stub.setup = function()
          if original_setup then
            original_setup()
          end
          opts.setup()
        end
      end
    end
  elseif opts.event == nil then
    vim.list_extend(plugins, spec)

    if opts.setup then
      table.insert(setup, opts.setup)
    end
  else
    ---@type PackAutocmdOpts
    local autocmd_opts = {
      event = opts.event,
      pattern = opts.pattern or '',
      setup = opts.setup,
    }

    group_by_autocmd(spec, autocmd_opts)
  end
end

---Install immediate plugins first, then register deferred installers, then run setup.
---@param plugin_list (string | vim.pack.Spec)[]
---@param context? string Context for profiling (e.g., 'sync', 'autocmd', 'cmd')
local function install_plugins(plugin_list, context)
  if #plugin_list == 0 then
    vim.pack.add(plugin_list)
    return
  end

  local start_time = vim.loop.hrtime()

  for _, spec in ipairs(plugin_list) do
    local plugin_name = spec
    if type(spec) ~= 'string' then
      plugin_name = spec.src
    end

    vim.pack.add { spec }

    local end_time = vim.loop.hrtime()
    local duration_ms = (end_time - start_time) / 1e6

    table.insert(load_times, {
      name = plugin_name,
      context = context or 'sync',
      start = start_time,
      duration = duration_ms,
    })

    start_time = end_time
  end
end

---Create command stubs for lazy-loaded plugins.
local function create_cmd_stubs()
  for _, stub in pairs(cmd_stubs) do
    for _, cmd in ipairs(stub.cmds) do
      vim.api.nvim_create_user_command(cmd, function(args)
        vim.api.nvim_del_user_command(cmd)
        install_plugins(stub.spec, 'cmd:' .. cmd)
        if stub.setup then
          stub.setup()
        end
        vim.cmd(cmd .. ' ' .. args.args)
      end, { nargs = '*' })
    end
  end
end

---Create one-shot autocmds for deferred plugin groups.
local function schedule_autocmds()
  for event, autocmd_group in pairs(autocmd_groups) do
    for pattern, group in pairs(autocmd_group) do
      ---@type string?
      local pat = nil

      if pattern ~= '' then
        pat = pattern
      end

      vim.api.nvim_create_autocmd(event, {
        pattern = pat,
        once = true,
        callback = function()
          install_plugins(group.spec, 'autocmd:' .. event)

          for _, setup_function in ipairs(group.setup) do
            setup_function()
          end
        end,
      })
    end
  end
end

local function install_sync()
  install_plugins(dedupe(plugins), 'sync')

  for _, setup_function in ipairs(setup) do
    setup_function()
  end
end

---Print plugin load time report in a markdown scratch buffer.
local function print_profile()
  if #load_times == 0 then
    vim.notify('No plugin load times recorded.', vim.log.levels.WARN)
    return
  end

  local total_time = 0

  for _, record in ipairs(load_times) do
    total_time = total_time + record.duration
  end

  -- Sort by duration descending
  local sorted = vim.deepcopy(load_times)
  table.sort(sorted, function(a, b)
    return a.duration > b.duration
  end)

  local lines = {
    '# 📦 Plugin Load Times',
    '',
    '| Plugin | Time | Context | % |',
    '|---|---|---|---|',
  }

  for _, record in ipairs(sorted) do
    local pct = (record.duration / total_time * 100)
    table.insert(lines, string.format('| `%s` | %.2fms | %s | %.0f%% |', record.name, record.duration, record.context, pct))
  end

  table.insert(lines, string.format('| **Total** | **%.2fms** | | %.0f%% |', total_time, 100))
  table.insert(lines, '')

  -- Create buffer with .md name so markview picks it up
  local bufnr = vim.api.nvim_create_buf(false, false)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

  -- Open in a new tab
  vim.cmd.tabnew()
  vim.api.nvim_win_set_buf(0, bufnr)

  -- Trigger BufReadPost so markview activates
  vim.api.nvim_exec_autocmds('BufReadPost', { buffer = bufnr })

  vim.bo[bufnr].modifiable = false
  vim.bo[bufnr].bufhidden = 'wipe'
  vim.bo[bufnr].buftype = 'nowrite'
  vim.bo[bufnr].filetype = 'markdown'
end

---Configure the pack module.
local function configure()
  vim.api.nvim_create_user_command('PackProfile', function()
    print_profile()
  end, { desc = 'Show plugin load time report' })
end

---Install immediate plugins first, then register deferred installers, then run setup.
local function install()
  install_sync()
  schedule_autocmds()
  create_cmd_stubs()
end

return {
  add = add,
  install = install,
  configure = configure,
  profile = print_profile,
}
