return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",

  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.vue" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.yaml" },
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

  { import = "astrocommunity.utility.noice-nvim" },

  { import = "astrocommunity.color.transparent-nvim" },

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
