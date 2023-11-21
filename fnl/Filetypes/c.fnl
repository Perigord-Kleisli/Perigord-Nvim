(local {: capabilities} (require :Lang.LSP))
(local clangd (require :clangd_extensions))
(local lspconfig (require :lspconfig))
(local {:debug-map dbg-map} (require :Mapping.Debug))
(local dapui (require :dapui))
(local dap (require :dap))

(let [command :lldb-vscode]
  (if (= nil command)
      (vim.notify "an LLDB_VSCODE envvar must be set with an absolute path to an 'lldb-vscode' exxecutable")
      (set dap.adapters.lldb {:type :executable : command :name :lldb})))

(set dap.configurations.c [{:name :launch
                            :type :lldb
                            :request :launch
                            :program #(vim.fn.input (.. "Path to executable: "
                                                        (vim.fn.getcwd) "/")
                                                    :file)
                            :cwd "${workspaceFolder}"
                            :stopOnEntry false
                            :args []}])

(dbg-map {:name " Debug"
          :with-default-heads true
          :remove [:n :<CR>]
          :config {:on_enter dapui.open :on_exit dapui.close}
          :heads [[:<CR> dap.continue {:desc "Start Debugging"}]]})

(local {:lang-map wk} (require :Mapping.Lang))
(local include-guard (require :include-guard))
(include-guard.setup {:copyright_holder :Perigord-Kleisli :add_copyright true})
(local {: cmd} (require :hydra.keymap-util))

(wk {:name "󰙱/++"
     :with-default-heads true
     :pattern [:*.c :*.h :*.cpp :*.cxx]
     :heads [[:o (cmd :Ouroboros) {:desc "Swap between header"}]
             [:I include-guard.AddIncludeGuard {:desc "Add Include Guard"}]]})

(clangd.setup {:server {: capabilities} :inlay_hints {} :autoSetHints true})
(lspconfig.clangd.setup {:server {: capabilities}
                         :cmd [:clangd :--offset-encoding=utf-16 :--clang-tidy :--all-scopes-completion]
                         :inlay_hints {}
                         :autoSetHints true})

(vim.defer_fn #(do
                (local inlay-hints (require :clangd_extensions.inlay_hints)) 
                (inlay-hints.setup_autocmd)
                (inlay-hints.set_inlay_hints))
              500)

(vim.cmd.LspStart :clangd)
