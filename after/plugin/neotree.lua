require("neo-tree").setup({
  filesystem = {
    window = {
      position = "current"
    },
    hijack_netrw_behavior = "open_current"
  }
})
