return {
  { -- colorscheme
    "Mofiqul/dracula.nvim",
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {},
    keys = {
      -- Tab で次のバッファへ
      { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      -- Shift + Tab で前のバッファへ
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      -- Leader + bj でバッファを直感的に選択 (Pickモード)
      { "<leader>bj", "<cmd>BufferLinePick<cr>", desc = "Buffer pick" },
      -- Leader + bc で他のバッファをすべて閉じる
      { "<leader>bc", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
    },
    lazy = false,
  },
  {
    "lewis6991/hover.nvim",
    config = function()
      require('hover').config({
        --- List of modules names to load as providers.
        --- @type (string|Hover.Config.Provider)[]
        providers = {
          'hover.providers.diagnostic',
          'hover.providers.lsp',
          'hover.providers.dap',
          'hover.providers.man',
          'hover.providers.dictionary',
          -- Optional, disabled by default:
          -- 'hover.providers.gh',
          -- 'hover.providers.gh_user',
          -- 'hover.providers.jira',
          -- 'hover.providers.fold_preview',
          -- 'hover.providers.highlight',
        },
        preview_opts = {
          border = 'single'
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = false,
        title = true,
        mouse_providers = {
          'hover.providers.lsp',
        },
        mouse_delay = 1000
      })
    end
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
  },
  -- { -- file explorer
  --   'preservim/nerdtree',
  -- },
  { -- file explorer
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('config/nvim-tree')
    end
  },
  {
    -- treesitter で terraform がハイライトされないので追加
    "hashivim/vim-terraform",
    lazy=false,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy=false,
    opts = {
			highlight = {
				enable = true,
				disable = {},
			},
			ensure_installed = { "hcl", "terraform", "toml", "lua" },
			sync_install = false,
		},
  },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = 'default' },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- 補完ウィンドウの見た目を少し豪華にする（オプション）
      completion = {
        menu = { border = 'rounded' },
        documentation = { window = { border = 'rounded' } },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },
  -- {
  --   "github/copilot.vim",
  --   lazy=false,
  -- },
  {
    "mattn/vim-goimports",
    lazy=false,
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {},
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
    keys = {},
    lazy = false,
  },
  -- {
  -- "yetone/avante.nvim",
  -- event = "VeryLazy",
  -- lazy = false,
  -- version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  -- opts = {
  -- 	-- add any opts here
  -- 	-- for example
  -- 	provider = "openai",
  -- 	openai = {
  -- 		endpoint = "https://api.openai.com/v1",
  -- 		model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
  -- 		timeout = 30000, -- timeout in milliseconds
  -- 		temperature = 0, -- adjust if needed
  -- 		max_tokens = 4096,
  -- 		-- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
  -- 	},
  -- },
  -- -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- build = "make",
  -- -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  -- dependencies = {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	"stevearc/dressing.nvim",
  -- 	"nvim-lua/plenary.nvim",
  -- 	"MunifTanjim/nui.nvim",
  -- 	--- The below dependencies are optional,
  -- 	"echasnovski/mini.pick", -- for file_selector provider mini.pick
  -- 	"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
  -- 	"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
  -- 	"ibhagwan/fzf-lua", -- for file_selector provider fzf
  -- 	"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  -- 	"zbirenbaum/copilot.lua", -- for providers='copilot'
  -- 	{
  -- 		-- support for image pasting
  -- 		"HakonHarnes/img-clip.nvim",
  -- 		event = "VeryLazy",
  -- 		opts = {
  -- 			-- recommended settings
  -- 			default = {
  -- 				embed_image_as_base64 = false,
  -- 				prompt_for_file_name = false,
  -- 				drag_and_drop = {
  -- 					insert_mode = true,
  -- 				},
  -- 				-- required for Windows users
  -- 				use_absolute_path = true,
  -- 			},
  -- 		},
  -- 	},
  -- 	{
  -- 		-- Make sure to set this up properly if you have lazy=true
  -- 		'MeanderingProgrammer/render-markdown.nvim',
  -- 		opts = {
  -- 			file_types = { "markdown", "Avante" },
  -- 		},
  -- 		ft = { "markdown", "Avante" },
  -- 	},
  -- },
  -- },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- インストール時にレジストリを更新
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "neovim/nvim-lspconfig" },
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { -- 自動インストールしたいサーバーをリストアップ
          "lua_ls", "pyright", "ts_ls", "vimls", "gopls", "html", "jsonls",
          "cssls", "marksman", "terraformls", "vuels", "dockerls", "yamlls",
        },
      })

      require("mason-lspconfig").setup_handlers({
        -- 自動セットアップ
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      })
    end
  },
  -- {
  --   'nvim-telescope/telescope.nvim', tag = '0.1.8',
  --   dependencies = {
  --     { 'nvim-lua/plenary.nvim' },
  --     { 'BurntSushi/ripgrep' },
  --   },
  -- },
  {
    "img-paste-devs/img-paste.vim",
    lazy=false,
  },
  -- {
  -- -- 補完エンジン本体
  -- "hrsh7th/nvim-cmp",
  --   lazy=false,
  -- dependencies = {
  -- 	"hrsh7th/cmp-buffer",   -- バッファ内の単語から補完
  -- 	"hrsh7th/cmp-path",     -- ファイルパスの補完
  -- },
  -- config = function()
  -- 	local cmp = require("cmp")
  -- 	cmp.setup({
  -- 		mapping = cmp.mapping.preset.insert({
  -- 			["<C-b>"] = cmp.mapping.scroll_docs(-4),
  -- 			["<C-f>"] = cmp.mapping.scroll_docs(4),
  -- 			["<C-Space>"] = cmp.mapping.complete(),
  -- 			["<C-e>"] = cmp.mapping.abort(),
  -- 			["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enterで確定
  -- 		}),
  -- 		sources = cmp.config.sources({
  -- 			-- { name = "codeium" },
  -- 			{ name = "buffer" },
  -- 			{ name = "path" },
  -- 		}),
  -- 	})
  -- end,
  -- },
  -- {
  --   "Exafunction/windsurf.nvim",
  --   lazy=false,
  --   dependencies = {
  --       "nvim-lua/plenary.nvim",
  --       "hrsh7th/nvim-cmp",
  --   },
  --   config = function()
  --       require("codeium").setup({
  -- 			-- cmp 用のソースを無効化し、Virtual Text に専念させる設定例
  -- 			enable_cmp_source = false,
  -- 			virtual_text = {
  -- 				enabled = true,
  -- 				-- キーバインドの設定（お好みに合わせて）
  -- 				key_bindings = {
  -- 					accept = "<tab>",    -- 採用：Tab
  -- 					next = "<M-]>",      -- 次の候補：Alt + ]
  -- 					prev = "<M-[>",      -- 前の候補：Alt + [
  -- 					dismiss = "<C-x>",   -- 閉じる：Ctrl + x
  -- 				}
  --       }
  --   })
  --   end
  -- },

}
