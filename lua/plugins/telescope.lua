return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<tab>"] = "move_selection_next",
          ["<S-tab>"] = "move_selection_previous",
        },
      },
    },
  },
}
