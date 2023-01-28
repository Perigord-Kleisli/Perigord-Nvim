(local Utils (require :Utils))
(local buf vim.lsp.buf)

(fn preview-location-callback [_ result]
  (when (or (= result nil) (vim.tbl_isempty result))
    (lua "return nil"))
  (vim.lsp.util.preview_location (. result 1)))

(fn Peek-definition []
  (let [params (vim.lsp.util.make_position_params)]
    (vim.lsp.buf_request 0 :textDocument/definition params
                         preview-location-callback)))

(fn map [key action desc]
  (vim.keymap.set :n key action {:noremap true :silent true : desc}))

(map :gD vim.lsp.buf.declaration "go to declaration")
(map "g]" vim.diagnostic.goto_next "go to next diagnostic")
(map "g[" vim.diagnostic.goto_prev "go to previous diagnostic")
(map :gd vim.lsp.buf.definition "go to definition")
(map :gr vim.lsp.buf.references "find references")
(map :gp Peek-definition "peek definition")
(map :K vim.lsp.buf.hover :hover)
(map :<C-k> vim.lsp.buf.signature_help "")
(map :gi vim.lsp.buf.implementation "go to implementation")

(local lsp-lines (require :lsp_lines))
(local heads
       [[:f #(buf.format {:async true}) {:desc :Format :exit true}]
        [:a buf.code_action {:desc "Code Action" :exit true}]
        [:r buf.rename {:desc :Rename :exit true}]
        [:L lsp-lines.toggle {:desc "Toggle Diagnostic Lines" :exit true}]])

(local lang-hydra (Utils.hydra-with-defaults {:mode :n
                                              :body :<leader>l
                                              : heads}))

(lang-hydra)
lang-hydra
