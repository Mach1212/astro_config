return {
  "AstroNvim/astrolsp",
  dependencies = {
    { "diogo464/kubernetes.nvim" },
  },
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      config = {
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                [require("kubernetes").yamlls_schema()] = "*.yaml",
              },
            },
          },
        },
      },
    })
  end,
}
