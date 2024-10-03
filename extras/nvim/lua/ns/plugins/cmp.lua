local MAX_ABBR_WIDTH = math.floor(vim.o.columns * 0.25)
local MAX_DOCUMENTATION_WIDTH = math.floor(vim.o.columns * 0.5)
local MAX_DOCUMENTATION_HEIGHT = math.floor(vim.o.lines * 0.5)

local kinds = {
  Buffer = "",
  --
  Text = "",
  Method = "",
  Function = "󰊕",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "󱔁",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

return {
  -- "hrsh7th/nvim-cmp",
  "yioneko/nvim-cmp",
  branch = "perf",
  enabled = true,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    {
      "garymjr/nvim-snippets",
      opts = {
        extended_filetypes = {
          typescriptreact = { "typescript" },
        },
      },
    },
  },
  event = { "InsertEnter" },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      -- NOTE: https://github.com/hrsh7th/nvim-cmp/issues/1809
      preselect = cmp.PreselectMode.None,
      performance = { max_view_entries = 9 },
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
      formatting = {
        --   expandable_indicator = true,
        -- fields = { "abbr", "kind" },
        -- fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          if entry.source.name == "buffer" then
            vim_item.kind = "Buffer"
          end

          if vim.api.nvim_strwidth(vim_item.abbr) > MAX_ABBR_WIDTH then
            vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, MAX_ABBR_WIDTH) .. "…"
          end

          -- vim_item.menu = vim_item.kind
          vim_item.kind = string.format("%s %s", kinds[vim_item.kind] or vim_item.kind, vim_item.kind)

          return vim_item
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-3),
        ["<C-d>"] = cmp.mapping.scroll_docs(3),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-j>"] = cmp.mapping(function()
          if vim.snippet.active({ direction = 1 }) then
            vim.snippet.jump(1)
          end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function()
          if vim.snippet.active({ direction = -1 }) then
            vim.snippet.jump(-1)
          end
        end, { "i", "s" }),
      }),
      window = {
        completion = {
          winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:Visual,Search:None",
          scrollbar = false,
          border = "rounded",
          -- col_offset = -1,
        },
        documentation = {
          winhighlight = "Normal:DocNormal,FloatBorder:DocBorder,CursorLine:Visual,Search:None",
          border = "rounded",
          max_width = MAX_DOCUMENTATION_WIDTH,
          max_height = MAX_DOCUMENTATION_HEIGHT,
        },
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "snippets" },
      }, {
        {
          name = "buffer",
          keyword_length = 3,
          option = {
            get_bufnrs = function()
              local cur_tabpage = vim.api.nvim_get_current_tabpage()
              local wins = vim.api.nvim_tabpage_list_wins(cur_tabpage)

              return vim
                .iter(wins)
                :map(function(v)
                  return vim.api.nvim_win_get_buf(v)
                end)
                :totable()
            end,
          },
        },
      }),
    })

    cmp.setup.filetype({ "sql" }, {
      sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
      },
    })

    vim.api.nvim_set_hl(0, "CmpItemKindCodeium", { link = "CmpItemKindCopilot" })
    vim.api.nvim_set_hl(0, "CmpItemKindBuffer", { link = "CmpItemKindText" })
  end,
}
