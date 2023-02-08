(local {:register wk} (require :which-key))
(local {: cmd} (require :hydra.keymap-util))
(fn lang-map [maps]
  (let [ft (. maps :name)
        hydra (require :hydra)
        lsp-lines (require :lsp_lines)
        defaults [[:f
                   #(vim.lsp.buf.format {:async true})
                   {:desc :Format :exit true}]
                  [:a vim.lsp.buf.code_action {:desc "Code Action" :exit true}]
                  [:e vim.lsp.codelens.run {:desc "Code lens" :exit true}]
                  [:r vim.lsp.buf.rename {:desc :Rename :exit true}]
                  [:t
                   (cmd :TroubleToggle)
                   {:desc "Toggle Diagnostic List" :exit true}]
                  [:s
                   (cmd :SymbolsOutline)
                   {:desc "Toggle Symboltree" :exit true}]
                  [:i (cmd :LspInfo) {:desc "LSP Info" :exit true}]
                  [:l
                   lsp-lines.toggle
                   {:desc "Toggle line diagnostics" :exit true}]]
        {: auto-gen-hint} (require :Utils)]
    (each [_ v (ipairs defaults)]
      (local intersecting? (do
                             (var x false)
                             (each [_ head (ipairs maps.heads)]
                               (when (= (. head 1) (. v 1))
                                 (set x true)
                                 (lua :break)))
                             (match maps.remove
                               removed (when (not x)
                                         (each [_ ignore (ipairs removed)]
                                           (when (= (. v 1) ignore)
                                             (set x true)
                                             (lua :break)))))
                             x))
      (when (not intersecting?)
        (table.insert maps.heads v)))
    (tset maps :hint (auto-gen-hint maps.heads ft))
    (tset maps :config {:hint {:type :window :border :single}})
    (local binds #(wk {:l [#(: (hydra maps) :activate)
                           (.. "+" (if (= 0 (string.len ft)) :Lang ft))]}
                      {:prefix :<leader>}))
    (vim.api.nvim_create_autocmd [:BufEnter :BufNewFile]
                                 {:pattern (?. maps :pattern)
                                  :buffer (?. maps :buffer)
                                  :callback binds})
    (binds)))

(local telescope (require :telescope.builtin))
(let [neotest (require :neotest)]
  (neotest.setup {:adapters [(require :neotest-rust)
                             (require :neotest-haskell)]})
  (wk {:r [neotest.run.run "Run test"]
       :d [#(neotest.run.run {:strategy :dap}) "Debug Test"]
       :s [neotest.run.stop "Stop Test"]
       :R [#(neotest.run.run (vim.fn.expand "%")) "Run All tests in buffer"]
       :o [neotest.output.open "View output"]
       :<enter> [neotest.summary.toggle "View Summary"]}
      {:prefix :<leader>s :name :Test}))

(wk {:D [vim.lsp.buf.declaration :Declaration]
     "]" [vim.diagnostic.goto_next "Next diagnostic"]
     "[" [vim.diagnostic.goto_next "Previous diagnostic"]
     :d [vim.lsp.buf.definition :Definition]
     :r [vim.lsp.buf.references :References]
     :i [vim.lsp.buf.implementation :Implementation]
     :/ [(. (require :link-visitor) :links_in_buffer) :Link]
     :t [telescope.live_grep :Text]} {:prefix :g :name "Go to"})

(vim.keymap.set :n :<C-k> vim.lsp.buf.signature_help
                {:noremap true :silent true :desc "signature help"})

(lang-map {:name :Lang :heads []})

(vim.api.nvim_create_autocmd :LspAttach
                             {:callback #(vim.cmd :SymbolsOutlineOpen)})

{: lang-map}
