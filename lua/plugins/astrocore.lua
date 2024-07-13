-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local sections = {
  R = { desc = require("astroui").get_icon("Package", 1, true) .. "Rust" },
  r = { desc = require("astroui").get_icon("ActiveLSP", 1, true) .. "Refactor" },
  A = { desc = require("astroui").get_icon("ActiveLSP", 1, true) .. "AI" },
}

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        mouse = "",
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
        mapleader = " ", -- sets vim.g.mapleader
        autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
        cmp_enabled = true, -- enable completion at start
        autopairs_enabled = true, -- enable autopairs at start
        diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
        icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
        ui_notifications_enabled = true, -- disable notifications when toggling UI elements
        resession_enabled = false, -- enable experimental resession.nvim session management (will be default in AstroNvim v4)
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command

        ["<leader>R"] = sections.R,
        ["<leader>Rt"] = { function() require("crates").toggle() end, desc = "Toggle" },
        -- ["<leader>RR"] = { function() require("crates").reload() end, desc = "Reload" },

        ["<leader>Rv"] = { function() require("crates").show_versions_popup() end, desc = "Versions" },
        ["<leader>Rf"] = { function() require("crates").show_features_popup() end, desc = "Features" },
        ["<leader>Rd"] = { function() require("crates").show_dependencies_popup() end, desc = "Dependencies" },

        ["<leader>Ru"] = { function() require("crates").update_crate() end, desc = "Update" },
        ["<leader>Ra"] = { function() require("crates").update_all_crates() end, desc = "Update All" },
        ["<leader>RU"] = { function() require("crates").update_crate() end, desc = "Upgrade" },
        ["<leader>RA"] = { function() require("crates").upgrade_all_crates() end, desc = "Upgrade Crates" },

        ["<leader>RH"] = { function() require("crates").open_homepage() end, desc = "Homepage" },
        ["<leader>RR"] = { function() require("crates").open_repository() end, desc = "Repo" },
        ["<leader>RD"] = { function() require("crates").open_documentation() end, desc = "Documentation" },
        ["<leader>RC"] = { function() require("crates").open_crates_io() end, desc = "Crates.io" },

        ["<leader>Rr"] = { function() require("rust-tools").runnables.runnables() end, desc = "Runnables" },

        ["<leader>r"] = sections.r,

        -- ["<leader>A"] = sections.A,
        -- ["<leader>Aa"] = { "<cmd>Gen<cr>" },

        -- ["<leader>wT"] = { "<cmd>ASToggle<cr>", desc = "Toggle auto-save" },
        ["<leader>ww"] = { "<cmd>wall<cr>", desc = "Save all" },
        ["<Leader>uN"] = {
          function()
            require("astrocore.toggles").notifications()
            require("notify").dismiss { silent = true }
          end,
          desc = "Toggle'n Clear Notifications",
        },

        ["<leader>td"] = {
          function() require("astrocore").toggle_term_cmd "sudo lazydocker" end,
          desc = "ToggleTerm LazyDocker",
        },

        ["<Leader>uT"] = { "<cmd>TransparentToggle<cr>", desc = "Toggle transparency" },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
      v = {
        ["<leader>R"] = sections.R,
        ["<leader>Ru"] = { function() require("crates").update_crates() end, desc = "Update" },
        ["<leader>RU"] = { function() require("crates").upgrade_crates() end, desc = "Upgrade" },

        ["<leader>r"] = sections.r,

        ["<leader>A"] = sections.A,
        ["<leader>Aa"] = { "<cmd>Gen<cr>" },
      },
    },
  },
}
