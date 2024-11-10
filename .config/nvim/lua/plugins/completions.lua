return {
<<<<<<< HEAD
    {
        "hrsh7th/cmp-nvim-lsp",
        event = "LspAttach",
    },
    {
        "L3MON4D3/LuaSnip",
        event = { "InsertEnter" },
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter" },
        dependencies = {
            "onsails/lspkind.nvim",
        },
        config = function()
            local cmp = require("cmp")
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			cmp.setup({
				experimental = { ghost_text = true },
				formatting = {
					format = require("lspkind").cmp_format({
						mode = "symbol_text",
						menu = {
							buffer = "[Buffer]",
							nvim_lsp = "[LSP]",
							luasnip = "[LuaSnip]",
							nvim_lua = "[Lua]",
							latex_symbols = "[Latex]",
						},
					}),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<tab>"] = cmp.mapping(cmp.mapping.confirm({ select = true })),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "copilot" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}
