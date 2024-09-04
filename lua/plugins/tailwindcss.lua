return {
  "AstroNvim/astrolsp",
  opts = {
    config = {
      tailwindcss = {
        filetypes = { "rust" },
        -- Dioxus class regex
        -- "tailwindCSS.experimental.classRegex": ["class: \"(.*)\""],
        -- "tailwindCSS.includeLanguages": {
        --     "rust": "html"
        --  },
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = { 'class:[\\s\\S]*?"(.*?)"', 'class:[\\s\\S]*?{.*?"(.*?)"' },
            },
          },
        },
        init_options = {
          userLanguages = {
            rust = "html",
          },
        },
      },
    },
  },
}
