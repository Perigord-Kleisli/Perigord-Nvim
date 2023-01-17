(local hydra (require :Mapping.Lang))
(local ht (require :haskell-tools))
(local capabilities (. (require :Lang.LSP) :capabilities))

;; fnlfmt: skip
(ht.setup
  {:hls
   {: capabilities
    :on_attach
      (fn [_client bufnr]
        (local _opts (vim.tbl_extend :keep {:noremap true :silent true} {:buffer bufnr}))
        (local extensions (. (require :telescope) :extensions))
        (ht.tags.generate_project_tags nil {:refresh true})

        (local cmd (. (require :hydra.keymap-util) :cmd))
        (macro cmd-tele [command]
          (.. "<CMD>Telescope " command :<CR>))

        (hydra {:name :Browse/Open
                :mode :n
                :config {:invoke_on_body true :foreign_keys :run :type :statusline}
                :body :<leader>o
                :heads [[:p (cmd :NvimTreeToggle) {:desc :Sidebar :exit true}]
                        [:t ht.repl.toggle {:desc :REPL :exit true}]
                        [:T (cmd :ToggleTerm) {:desc :Terminal :exit true}]
                        [:r (cmd-tele :oldfiles) {:desc "Recent Files" :exit true}]
                        [:h (cmd :BufferLineCyclePrev) {:desc "Previous Buffer"}]
                        [:l (cmd :BufferLineCycleNext) {:desc "Next Buffer"}]
                        [:<esc> nil {:desc :Exit :exit true}]]})

        (hydra {:extra-heads [[:R ht.repl.toggle {:desc "Toggle REPL" :exit true}]
                              [:<C-r> ht.repl.reload {:desc "Reload REPL" :exit true}]
                              [:h extensions.hoogle.hoogle {:desc :Hoogle :exit true}]
                              [:e vim.lsp.codelens.run {:desc "Evaluate Codelens" :exit true}]]}))}})

(vim.cmd ":LspStart hls")
