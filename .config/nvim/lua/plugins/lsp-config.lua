return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "jsonls",
                    "rust_analyzer",
                    "cssls",
                    "markdown_oxide",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
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
            lspconfig.lua_ls.setup({ capabilities = capabilities })
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
            lspconfig.jsonls.setup({ capabilities = capabilities })
            lspconfig.cssls.setup({ capabilities = capabilities })
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = { allFeatures = true },
                    },
                },
            })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },
}
