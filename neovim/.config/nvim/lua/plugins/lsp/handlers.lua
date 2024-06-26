local icons = require("utils.icons").lsp

local M = {}

function M.setup()
    -- LSP handlers configuration
    local diagnostics = {
        virtual_text = {
            spacing = 4,
        },
        update_in_insert = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
        },
    }

    -- Diagnostic signs
    local diagnostic_signs = {
        { name = "DiagnosticSignError", text = icons.error },
        { name = "DiagnosticSignWarn", text = icons.warn },
        { name = "DiagnosticSignInfo", text = icons.info },
        { name = "DiagnosticSignHint", text = icons.hint },
        { name = "DiagnosticSignOk", text = icons.ok },
    }

    for _, sign in ipairs(diagnostic_signs) do
        vim.fn.sign_define(sign.name, {
            texthl = sign.name,
            text = sign.text,
            numhl = sign.name,
        })
    end

    -- Diagnostic configuration
    vim.diagnostic.config(diagnostics)

    -- Hover configuration
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, diagnostics.float)

    -- Signature help configuration
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, diagnostics.float)
end

return M

