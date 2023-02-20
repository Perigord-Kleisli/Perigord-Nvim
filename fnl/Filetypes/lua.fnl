(let [{: capabilities} (require :Lang.LSP)
      lspconfig (require :lspconfig)
      neodev (require :neodev)]

  (var runtime-path (vim.split package.path ";"))
  (table.insert runtime-path :lua/?.lua)
  (table.insert runtime-path :lua/?/init.lua)

  (neodev.setup {:override (fn [root lib]
                             (local neodev-util (require :neodev-util))
                             (if (neodev-util.has_file root :/etc/nixos)
                                 (set lib.enabled true)
                                 (set lib.plugins true)))})

  (lspconfig.lua_ls.setup {: capabilities
                                :settings {:Lua {:runtime {:version :LuaJIT
                                                           :path runtime-path}
                                                 :diagnostics {:globals [:vim]}
                                                 :workspace {:library (vim.api.nvim_get_runtime_file ""
                                                                                                     true)}
                                                 :telemetry {:enable false}}}}))

(vim.cmd "LspStart lua_ls")
