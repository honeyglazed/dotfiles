local M = {}
local ignore_patterns = {"Android/.*",
                         "books/.*",
                         "android.*",
                         "downloads/.*",
                         "games/.*",
                         "AndroidStudioProjects",
                         "bin/.*",
                         "node_modules/.*"}

require('telescope').setup {
  defaults = {
    layout_strategy = "vertical",
    file_ignore_patterns = ignore_patterns,

    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    file_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}

require("telescope").load_extension("fzy_native")


