local lsps = {
    lua_ls = "lua",
    pyright = "python",
    ruff = "python",
    jsonls = "json",
    rust_analyzer = "rust",
    cssls = "css",
    clangd = { "c", "cpp" }
}

local exclude_from_auto_setup = {
    "pyright",
    "rust_analyzer",
    "ruff"
}

local ft = {}
for _, filetypes in pairs(lsps) do
    if type(filetypes) == "table" then
        for _, ft_item in ipairs(filetypes) do
            table.insert(ft, ft_item)
        end
    else
        table.insert(ft, filetypes)
    end
end

return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        ft = ft,
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = vim.tbl_keys(lsps),
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        ft = ft,
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            for server, _ in pairs(lsps) do
                if not vim.tbl_contains(exclude_from_auto_setup, server) then
                    lspconfig[server].setup({ capabilities = capabilities })
                end
            end

            lspconfig.ruff.setup({
                handlers = {
                    ["textDocument/hover"] = function() end,
                    ["textDocument/definition"] = function() end,
                },
                capabilities = capabilities,
                init_options = {
                    settings = {
                        organizeImports = true,
                        lint = {
                            enable = true,
                        },
                    },
                },
            })
            lspconfig.pyright.setup({
                capabilities = (function()
                    local cloned_capabilities = vim.deepcopy(capabilities)
                    cloned_capabilities.textDocument.publishDiagnostics =
                        vim.lsp.protocol.make_client_capabilities().textDocument.publishDiagnostics
                    cloned_capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
                    return cloned_capabilities
                end)(),
                settings = {
                    python = {
                        analysis = {
                            useLibraryCodeForTypes = true,
                            diagnosticSeverityOverrides = {
                                reportUnusedVariable = "warning",
                            },
                            typeCheckingMode = "normal",
                        },
                    },
                },
            })
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = { allFeatures = true },
                    },
                },
                handlers = { -- https://github.com/neovim/neovim/issues/30985
                    ["textDocument/diagnostic"] = function(err, result, context, config)
                        if err ~= nil and err.code == -32802 then
                            return
                        end
                        return vim.lsp.handlers["textDocument/diagnostic"](err, result, context, config)
                    end,
                    ["workspace/diagnostic"] = function(err, result, context, config)
                        if err ~= nil and err.code == -32802 then
                            return
                        end
                        return vim.lsp.handlers["workspace/diagnostic"](err, result, context, config)
                    end,
                },
            })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
