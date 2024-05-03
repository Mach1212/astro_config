-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- import/override with your plugins folder

  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.nix" },
  { import = "astrocommunity.pack.vue" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.yaml" },
  -- {
  --   "b0o/SchemaStore.nvim",
  --   opts = {
  --     config = {
  --       yamlls = {
  --         on_new_config = function(config)
  --           config.settings.yaml.schemas = {
  --             kubernetes = "*.yaml",
  --             ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
  --             ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
  --             ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
  --             ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
  --             ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
  --             ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
  --             ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
  --             ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
  --             ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
  --             ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
  --             ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
  --             ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
  --           }
  --         end,
  --       },
  --     },
  --   },
  -- },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.ansible" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.pack.tailwindcss" },

  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.mini-move" },
  { import = "astrocommunity.motion.mini-bracketed" },
  { import = "astrocommunity.motion.mini-surround" },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "<leader>zf", -- Add surrounding in Normal and Visual modes
        delete = "<leader>zd", -- Delete surrounding
        find = "", -- Find surrounding (to the right)
        find_left = "", -- Find surrounding (to the left)
        highlight = "", -- Highlight surrounding
        replace = "<leader>zr", -- Replace surrounding
        update_n_lines = "<leader>zn", -- Update `n_lines`

        suffix_last = "N", -- Suffix to search with "prev" method
        suffix_next = "n", -- Suffix to search with "next" method
      },
    },
  },

  { import = "astrocommunity.utility.noice-nvim" },

  { import = "astrocommunity.color.transparent-nvim" },
  {
    "xiyaowong/transparent.nvim",
    build = function() vim.cmd "TransparentEnable" end,
  },

  { import = "astrocommunity.editing-support.neogen" },
  -- { import = "astrocommunity.editing-support.auto-save-nvim" },
  -- {
  --   "Pocco81/auto-save.nvim",
  --   opt = { enabled = false },
  -- },
  { import = "astrocommunity.editing-support.refactoring-nvim" },
  { import = "astrocommunity.editing-support.nvim-regexplainer" },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },

  { import = "astrocommunity.markdown-and-latex.vimtex" },

  { import = "astrocommunity.syntax.hlargs-nvim" },
}
