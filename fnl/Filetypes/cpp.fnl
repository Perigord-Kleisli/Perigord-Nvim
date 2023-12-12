(local {: capabilities} (require :Lang.LSP))
(local clangd (require :clangd_extensions))
(local lspconfig (require :lspconfig))
(local {:debug-map dbg-map} (require :Mapping.Debug))
(local dapui (require :dapui))
(local dap (require :dap))
(local {: get-executables} (require :Utils))

(set dap.adapters.lldb {:type :executable :command :lldb-vscode :name :lldb})

(var executable-defined false)

(fn on_enter []
  (when (not executable-defined)
    (vim.ui.select (get-executables) {:prompt "Select program to debug:"}
                   (fn [program]
                     (var args [])
                     (var argc 0)
                     (var arg (vim.fn.input "Specify program arguments: "))
                     (while (not= arg "")
                      (table.insert args arg) 
                      (set argc (+ 1 argc))
                      (set arg (vim.fn.input (.. "Specify program arguments[" argc "]: "))))
                     (vim.notify (.. "Debugging: " program))
                     (set executable-defined true)
                     (set dap.configurations.cpp
                          [{:name :launch
                            :type :lldb
                            :request :launch
                            : program
                            :cwd "${workspaceFolder}"
                            :stopOnEntry false
                            : args}]))))
  (dapui.open))
(fn on_exit []
  (dapui.close))

(dbg-map {:name " Debug"
          :with-default-heads true
          :remove [:n :<CR>]
          :config {: on_enter : on_exit}
          :heads [[:<CR> dap.continue {:desc "Start Debugging"}]]})

(local {:lang-map wk} (require :Mapping.Lang))
(local include-guard (require :include-guard))
(include-guard.setup {:copyright_holder :Perigord-Kleisli :add_copyright true})
(local {: cmd} (require :hydra.keymap-util))

(wk {:name "󰙱++"
     :with-default-heads true
     :pattern [:*.c :*.h]
     :heads [[:o (cmd :Ouroboros) {:desc "Swap between header"}]
             [:I include-guard.AddIncludeGuard {:desc "Add Include Guard"}]]})

(clangd.setup {:server {: capabilities} :inlay_hints {} :autoSetHints true})
(lspconfig.clangd.setup {:server {: capabilities}
                         :cmd [:clangd
                               :--offset-encoding=utf-16
                               :--clang-tidy
                               :--all-scopes-completion]
                         :inlay_hints {}
                         :autoSetHints true})

(vim.defer_fn #(do
                 (local inlay-hints (require :clangd_extensions.inlay_hints))
                 (inlay-hints.setup_autocmd)
                 (inlay-hints.set_inlay_hints)) 500)

(vim.cmd.LspStart :clangd)
