(local {:register wk} (require :which-key))
(local {: cmd} (require :hydra.keymap-util))

(local default-maps
       (let [lsp-lines (require :lsp_lines)]
         [[:f #(vim.lsp.buf.format {:async true}) {:desc :Format}]
          [:a vim.lsp.buf.code_action {:desc "Code Action"}]
          [:e vim.lsp.codelens.run {:desc "Code lens"}]
          [:r vim.lsp.buf.rename {:desc :Rename}]
          [:t (cmd :TroubleToggle) {:desc "Toggle Diagnostic List"}]
          [:s (cmd :Navbuddy) {:desc "Toggle Navbuddy"}]
          [:i (cmd :LspInfo) {:desc "LSP Info"}]
          [:LL
           #(require (.. :Filetypes. vim.bo.filetype))
           {:desc "Force load lang"}]
          [:l lsp-lines.toggle {:desc "Toggle line diagnostics"}]]))

(fn with-default-maps [maps remove-load?]
  (each [_ v (ipairs default-maps)]
    (when (not (and (= nil remove-load?) (= (. v 1) :LL)))
      (table.insert maps v)))
  maps)

(fn lang-map [hydra-opts remove-load]
  (var hydra-opts hydra-opts)
  (let [hydra (require :hydra)
        {: auto-gen-hint} (require :Utils)]
    (match (?. hydra-opts :with-default-heads)
      true (tset hydra-opts :heads
                 (with-default-maps hydra-opts.heads remove-load)))
    (set hydra-opts
         (vim.tbl_deep_extend :keep hydra-opts
                              {:name :Lang
                               :hint (auto-gen-hint hydra-opts.heads
                                                    (or (?. hydra-opts :name)
                                                        :Lang))
                               :config {:foreign_keys :run
                                        :color :blue
                                        :hint {:border :rounded}}}))
    (local binds #(wk {:l [#(: (hydra hydra-opts) :activate)
                           (.. "+" hydra-opts.name)]}
                      {:prefix :<leader>}))
    (vim.api.nvim_create_autocmd [:BufEnter :BufNewFile]
                                 {:pattern (?. hydra-opts :pattern)
                                  :buffer (?. hydra-opts :buffer)
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
     "[" [vim.diagnostic.goto_prev "Previous diagnostic"]
     :d [vim.lsp.buf.definition :Definition]
     :r [vim.lsp.buf.references :References]
     :i [vim.lsp.buf.implementation :Implementation]
     :/ [(. (require :link-visitor) :links_in_buffer) :Link]
     :t [telescope.live_grep :Text]} {:prefix :g :name "Go to"})

(vim.keymap.set :n :<C-k> vim.lsp.buf.signature_help
                {:noremap true :silent true :desc "signature help"})

(lang-map {:name :Lang :heads default-maps :config {:exit true}} false)

{: lang-map : default-maps}
