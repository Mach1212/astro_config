return {
  "kiyoon/jupynium.nvim",
  build = "pip3 install .",
  -- build = "conda run --no-capture-output -n jupynium pip install .",
  -- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
  event = "VeryLazy",
  ft = "python,rust",
  config = function()
    require("jupynium").setup {
      default_notebook_URL = "http://k8s.mpruchn.com:30001/user/mach12/nbclassic/tree",
      firefox_profiles_ini_path = "/home/mach12/.mozilla/firefox/profiles.ini",
      firefox_profile_name = "selenium",
      autoscroll = {
        cell = {
          top_margin_percent = 5,
        },
      },

      scroll = {
        cell = {
          top_margin_percent = 5,
        },
      },
    }
  end,
}
