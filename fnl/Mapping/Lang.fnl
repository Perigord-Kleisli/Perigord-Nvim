(fn preview-location-callback [_ result]
  (when (or (= result nil) (vim.tbl_isempty result))
    (lua "return nil"))
  (vim.lsp.util.preview_location (. result 1)))

(fn Peek-definition []
  (let [params (vim.lsp.util.make_position_params)]
    (vim.lsp.buf_request 0 :textDocument/definition params
                         preview-location-callback)))

(local {:register wk} (require :which-key))
(local {: cmd} (require :hydra.keymap-util))

(let [ft vim.bo.filetype]
  (if (= 0 (string.len ft)) :Lang ft))

(fn lang-map [maps]
  (wk maps {:prefix :<leader>l
            :name (let [ft vim.bo.filetype]
                    (if (= 0 (string.len ft)) :Lang
                        (ft:gsub "^%l" string.upper)))}))

(local lsp-lines (require :lsp_lines))
(wk {:D [vim.lsp.buf.declaration :Declaration]
     "]" [vim.diagnostic.goto_next "Next diagnostic"]
     "[" [vim.diagnostic.goto_next "Previous diagnostic"]
     :d [vim.lsp.buf.definition :Definition]
     :r [vim.lsp.buf.references :References]
     :p [Peek-definition "Definition peek"]
     :i [vim.lsp.buf.implementation :Implementation]}
    {:prefix :g :name "Go to"})

(lang-map {:f [#(vim.lsp.buf.format {:async true}) :Format]
           :a [vim.lsp.buf.code_action "Code Action"]
           :e [vim.lsp.codelens.run "Code lens"]
           :r [vim.lsp.buf.rename :Rename]
           :i [(cmd :LspInfo) "LSP Info"]
           :L [lsp-lines.toggle "Toggle line diagnostics"]})

(vim.keymap.set :n :K vim.lsp.buf.hover
                {:noremap true :silent true :desc :hover})

(vim.keymap.set :n :<C-k> vim.lsp.buf.signature_help
                {:noremap true :silent true :desc "signature help"})

{: lang-map}
