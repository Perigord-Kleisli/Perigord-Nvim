local status_ok, godbolt = pcall(require, 'godbolt')
if not status_ok then
   vim.notify("Error importing: Godbolt")
   return
end

godbolt.setup({
    c = { compiler = "cg112", options = {} },
    cpp = { compiler = "g112", options = {} },
    rust = { compiler = "r1560", options = {} },
    -- any_additional_filetype = { compiler = ..., options = ... },
    quickfix = {
        enable = false, -- whether to populate the quickfix list in case of errors
        auto_open = false -- whether to open the quickfix list if the compiler outputs errors
    }
})
