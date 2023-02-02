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
(fn lang-map [maps]
  (let [ft (. maps :name)
        hydra (require :hydra)
        lsp-lines (require :lsp_lines)
        defaults [[:f #(vim.lsp.buf.format {:async true}) {:desc :Format}]
                  [:a vim.lsp.buf.code_action {:desc "Code Action"}]
                  [:e vim.lsp.codelens.run {:desc "Code lens"}]
                  [:r vim.lsp.buf.rename {:desc :Rename}]
                  [:t (cmd :TroubleToggle) {:desc "Toggle Diagnostic List"}]
                  [:i (cmd :LspInfo) {:desc "LSP Info"}]
                  [:L lsp-lines.toggle {:desc "Toggle line diagnostics"}]]
        {: auto-gen-hint} (require :Utils)]
    (var heads (. maps :heads))
    (each [_ v (ipairs defaults)]
      (table.insert heads v))
    (tset maps :heads heads)
    (tset maps :hint (auto-gen-hint heads (. maps :name)))
    (tset maps :config {:exit true :hint {:type :window :border :single}})
    (local binds #(wk {:l [#(: (hydra maps) :activate)
                           (.. "+" (if (= 0 (string.len ft)) :Lang ft))]}
                      {:prefix :<leader>}))
    (vim.api.nvim_create_autocmd [:BufEnter :BufNewFile]
                                 {:pattern (?. maps :pattern)
                                  :buffer (?. maps :buffer)
                                  :callback binds})
    (binds)))

(wk {:D [vim.lsp.buf.declaration :Declaration]
     "]" [vim.diagnostic.goto_next "Next diagnostic"]
     "[" [vim.diagnostic.goto_next "Previous diagnostic"]
     :d [vim.lsp.buf.definition :Definition]
     :r [vim.lsp.buf.references :References]
     :p [Peek-definition "Definition peek"]
     :i [vim.lsp.buf.implementation :Implementation]}
    {:prefix :g :name "Go to"})

(vim.keymap.set :n :K vim.lsp.buf.hover
                {:noremap true :silent true :desc :hover})

(vim.keymap.set :n :<C-k> vim.lsp.buf.signature_help
                {:noremap true :silent true :desc "signature help"})

(lang-map {:name :Lang :heads []})

{: lang-map}
