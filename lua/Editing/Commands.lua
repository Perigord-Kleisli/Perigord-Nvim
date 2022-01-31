
--[[
    # Editing.Commands
        -   Controls the commands and autocommands
--]]

vim.cmd[[command! CommentBox execute "lua require('nvim-comment-frame').add_comment()"]]
vim.cmd[[command! COMMENTBOX execute "lua require('nvim-comment-frame').add_multiline_comment()"]]
vim.cmd[[command! Formata  execute "lua vim.lsp.buf.formatting_sync()"]]






