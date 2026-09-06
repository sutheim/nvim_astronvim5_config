-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

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
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
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
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes:1", -- always show one sign column
        undodir = vim.fn.expand "$HOME/.vim.undodir",
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
        undotree_DiffAutoOpen = 0,
        undotree_SetFocusWhenToggle = 1,
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        L = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        H = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        ["<Leader>u"] = { vim.cmd.UndotreeToggle, desc = "Toggle UndoTree Window" },
        ["N"] = { "Nzz", desc = "Next and center" },
        ["n"] = { "nzz", desc = "Next and center" },
        ["<C-u>"] = { "<C-u>zz", desc = "Half page up and center" },
        ["<C-d>"] = { "<C-d>zz", desc = "Half page down and center" },
        ["gd"] = { "gdzz", desc = "Show definition and center" },
        ["<Leader>b"] = { desc = "Buffers" },
        ["<Leader>r"] = { desc = " Rust Tools" },
        ["<Leader>rf"] = {
          function()
            for _ = 1, 2, 1 do
              require("crates").show_features_popup()
            end
          end,
          desc = "Crate Show Features",
        },
        ["<Leader>rv"] = {
          function()
            for _ = 1, 2, 1 do
              require("crates").show_versions_popup()
            end
          end,
          desc = "Crate Show Versions",
        },
        ["<Leader>rd"] = {
          function() vim.cmd.RustLsp "relatedDiagnostics" end,
          desc = "Show related diagnostics",
        },
        ["<Leader>rc"] = {
          function() vim.cmd.RustLsp "openCargo" end,
          desc = "Open Cargo.toml for current crate",
        },
        ["<Leader>rp"] = {
          function() vim.cmd.RustLsp "parentModule" end,
          desc = "Open parent module",
        },
        ["<C-Q>"] = false,
      },
      v = {
        ["<C-g>"] = {
          function() require("snacks").picker.grep_word() end,
          desc = "Activates Snacks grep visual selection args",
        },
      },
      i = {
        ["<C-k>"] = { vim.lsp.buf.signature_help },
        ["<C-Q>"] = false,
      },
      t = {

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
  },
}
