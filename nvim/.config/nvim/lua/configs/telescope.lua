return function(_, opts)
  opts.defaults = opts.defaults or {}
  opts.defaults.mappings = opts.defaults.mappings or {}
  opts.defaults.mappings.i = vim.tbl_extend("force", opts.defaults.mappings.i or {}, {
    ["<Esc>"] = require("telescope.actions").close,
  })

  return opts
end
