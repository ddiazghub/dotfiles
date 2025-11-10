return {
  root_dir = function(bufnr, on_dir)
    local project_root = vim.fn.getcwd()
    local filename = vim.api.nvim_buf_get_name(bufnr)
    local biome_config_files = { 'biome.json', 'biome.jsonc' }

    local is_buffer_using_biome = vim.fs.find(biome_config_files, {
      path = filename,
      type = 'file',
      limit = 1,
      upward = true,
      stop = vim.fs.dirname(vim.fn.fnamemodify(vim.fn.getcwd(), ':h')),
    })

    if not is_buffer_using_biome then
      return
    end

    on_dir(project_root)
  end,
}
