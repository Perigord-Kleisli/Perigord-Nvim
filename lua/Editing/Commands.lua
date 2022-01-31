
--[[
    # Editing.Commands
        -   Controls the commands and autocommands
--]]

vim.cmd[[command! CommentBox execute "lua require('nvim-comment-frame').add_comment()"]]
vim.cmd[[command! McommentBox execute "lua require('nvim-comment-frame').add_multiline_comment()"]]



