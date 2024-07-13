-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
      -- denols = function(opts)
      --   opts.root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
      --   return opts
      -- end,
      -- tsserver = function(opts)
      --   opts.root_dir = require("lspconfig.util").root_pattern "package.json"
      --   return opts
      -- end,
      -- -- For eslint:
      -- eslint = function(opts)
      --   opts.root_dir =
      --     require("lspconfig.util").root_pattern("package.json", ".eslintrc.json", ".eslintrc.js", ".eslintrc.cjs")
      --   return opts
      -- end,
      yamlls = {
        settings = {
          yaml = {
            schemas = {
              kubernetes = "*.k8s.{yml,yaml}",
              ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
              ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
              ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
              ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
              ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
              ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
              ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
              ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
              ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
              ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
              ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
            },
          },
        },
      },
    },
    plugins = {
      { -- override nvim-cmp plugin
        "hrsh7th/nvim-cmp",
        -- override the options table that is used in the `require("cmp").setup()` call
        opts = function(_, opts)
          -- opts parameter is the default options table
          -- the function is lazy loaded so cmp is able to be required
          local cmp = require "cmp"
          -- modify the sources part of the options table
          opts.sources = cmp.config.sources {
            { name = "jupynium", priority = 1250 }, -- consider higher priority than LSP
            { name = "nvim_lsp", priority = 1000 },
            { name = "luasnip", priority = 750 },
            { name = "buffer", priority = 500 },
            { name = "path", priority = 250 },
          }
          -- return the new table to be used
          return opts
        end,
      },
      {
        "jay-babu/mason-null-ls.nvim",
        opts = {
          handlers = {
            prettierd = function()
              require("null-ls").register(require("null-ls").builtins.formatting.prettierd.with {
                condition = function(utils)
                  return utils.root_has_file { ".prettierrc", ".prettierrc.json", ".prettierrc.js" }
                end,
              })
            end,
            deno_fmt = function()
              require("null-ls").register(require("null-ls").builtins.formatting.deno_fmt.with {
                condition = function(utils) return utils.root_has_file { "deno.jsonc", "deno.json" } end,
              })
            end,
          },
        },
      },
    },

    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      dioxus_autoformat_on_save = {
        cond = function(client, bufnr)
          return client.name == "rust-analyzer"
            and require("null-ls.utils").make_conditional_utils().has_file { "Dioxus.toml" }
        end,
        {
          event = { "BufWritePost" },
          desc = "Auto-format Rust files after saving",
          callback = function() vim.cmd ":!dx fmt" end,
        },
      },

      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_codelens_refresh = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/codeLens",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "InsertLeave", "BufEnter" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
          end,
        },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
    end,
  },
}
