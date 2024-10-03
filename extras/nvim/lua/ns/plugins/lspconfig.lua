local methods = vim.lsp.protocol.Methods

vim.lsp.handlers[methods.textDocument_hover] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.lsp.handlers[methods.textDocument_signatureHelp] =
  vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("ns/lsp", {}),
  callback = function(ev)
    -- :help lsp-defaults

    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    assert(client, "lsp client not found")

    local opts = { buffer = ev.buf }

    vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)

    vim.keymap.set({ "n" }, "<Leader>cr", vim.lsp.buf.rename, opts)

    vim.keymap.set({ "n", "x" }, "<Leader>ca", vim.lsp.buf.code_action, opts)
  end,
})

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    -- "williamboman/mason.nvim",
    "b0o/schemastore.nvim",
    "Bilal2453/luvit-meta",
  },
  event = "VeryLazy",
  config = function()
    local lspconfig = require("lspconfig")
    -- local registry = require("mason-registry")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local capabilities =
      vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), cmp_nvim_lsp.default_capabilities())

    -- local vue_language_server_path = registry.get_package("vue-language-server"):get_install_path()
    -- .. "/node_modules/@vue/language-server"

    lspconfig.jsonls.setup({
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })

    lspconfig.vtsls.setup({
      capabilities = capabilities,
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
      },
      settings = {
        -- javascript = {
        --   suggest = { completeFunctionCalls = true },
        -- },
        -- typescript = {
        --   suggest = { completeFunctionCalls = true },
        -- },
        vtsls = {
          experimental = {
            maxInlayHintLength = 30,
            completion = {
              enableServerSideFuzzyMatch = true,
            },
          },
          tsserver = {
            globalPlugins = {
              {
                name = "@vue/typescript-plugin",
                location = os.getenv("XDG_DATA_HOME") .. "/npm/lib/node_modules/@vue/language-server",
                languages = { "vue" },
                configNamespace = "typescript",
                enableForWorkspaceTypeScriptVersions = true,
              },
            },
          },
        },
      },
    })

    for _, server in ipairs({
      "lua_ls",
      "clangd",
      "html",
      "cssls",
      -- "emmet_language_server",
      "eslint",
      "volar",
      "astro",
      "tailwindcss",
      "gopls",
    }) do
      lspconfig[server].setup({ capabilities = capabilities })
    end
  end,
}
