--[[
    # Editing.Commands
        -   Controls the commands and autocommands
--]]

vim.cmd [[command! CommentBox execute "lua require('nvim-comment-frame').add_comment()"]]
vim.cmd [[command! COMMENTBOX execute "lua require('nvim-comment-frame').add_multiline_comment()"]]
vim.cmd [[command! Formata  execute "lua vim.lsp.buf.formatting_sync()"]]

vim.cmd [[
	augroup _general_settings
	    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
	    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
	augroup end
]]
-- enable direct exit on q on some buffers
-- temporarily highlight text on copy

vim.cmd [[
      augroup _alpha
         autocmd FileType alpha echo "asd" 
      augroup end
]]
