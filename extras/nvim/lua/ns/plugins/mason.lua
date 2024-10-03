return {
  "williamboman/mason.nvim",
  enabled = false,
  cmd = "Mason",
  event = "VeryLazy",
  opts = {
    settings = {},
    ensure_installed = {
      "lua-language-server",
      "json-lsp",
      "html-lsp",
      "css-lsp",
      "vtsls",
      "vue-language-server",
      "astro-language-server",
      "emmet-language-server",
      "tailwindcss-language-server",
      "eslint-lsp",
      "prettierd",
      "stylua",
      "gopls",
      "gofumpt",
      "goimports",
      "clangd",
    },
  },
  config = function(_, opts)
    require("mason").setup(opts.settings)

    local registry = require("mason-registry")

    registry.refresh(function()
      for _, name in pairs(opts.ensure_installed) do
        local package = registry.get_package(name)
        if not registry.is_installed(name) then
          package:install()
        else
          package:check_new_version(function(success, result_or_err)
            if success then
              package:install({ version = result_or_err.latest_version })
            end
          end)
        end
      end
    end)
  end,
}
