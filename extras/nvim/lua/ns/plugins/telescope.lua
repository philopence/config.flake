return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      enabled = vim.fn.executable("make") == 1,
      build = "make",
    },
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  event = "VeryLazy",
  cmd = "Telescope",
  keys = {
    { "<Leader>/", "<Cmd>Telescope current_buffer_fuzzy_find<CR>" },
    { "<Leader>ff", "<Cmd>Telescope find_files<CR>" },
    { "<Leader>fb", "<Cmd>Telescope buffers<CR>" },
    { "<Leader>fw", "<Cmd>Telescope grep_string<CR>", mode = { "n", "x" } },
    { "<Leader>fg", "<Cmd>Telescope live_grep<CR>" },
    { "<Leader>fh", "<Cmd>Telescope help_tags<CR>" },
    { "<Leader>fM", "<Cmd>Telescope file_browser<CR>" },
    { "<Leader>fm", "<Cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>" },

    { "gd", "<Cmd>Telescope lsp_definitions<CR>" },
    { "gr", "<Cmd>Telescope lsp_references<CR>" },
    { "gt", "<Cmd>Telescope lsp_type_definitions<CR>" },
    { "gi", "<Cmd>Telescope lsp_implementations<CR>" },

    { "<Leader>cs", "<Cmd>Telescope lsp_document_symbols<CR>", desc = "code symbols" },
    { "<Leader>cd", "<Cmd>Telescope diagnostics<CR>", desc = "code diagnostics" },
  },
  opts = function()
    local actions = require("telescope.actions")
    local layout = require("telescope.actions.layout")
    return {
      defaults = {
        prompt_prefix = "$ ",
        selection_caret = "▌ ",
        path_display = {
          filename_first = true,
        },
        preview = {
          hide_on_startup = false,
        },
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.50,
            width = 0.75,
            height = 0.75,
          },
          vertical = {
            height = 0.75,
            width = 0.55,
            preview_height = 0.50,
            preview_cutoff = 20,
            prompt_position = "top",
            mirror = true,
          },
        },
        mappings = {
          i = {
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<A-p>"] = layout.toggle_preview,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = true,
          file_ignore_patterns = { "node_modules/", ".git/" },
        },
        current_buffer_fuzzy_find = {
          previewer = false,
        },
      },
      extensions = {
        file_browser = {
          grouped = true,
          hide_parent_dir = true,
          dir_icon = "",
          dir_icon_hl = "Directory",
          hidden = { file_browser = true, folder_browser = true },
          git_status = false,
          create_from_prompt = false,
        },
      },
    }
  end,
  config = function(_, opts)
    require("telescope").setup(opts)

    for _, extension in ipairs({
      "fzf",
      "ui-select",
      "file_browser",
    }) do
      require("telescope").load_extension(extension)
    end
  end,
}
