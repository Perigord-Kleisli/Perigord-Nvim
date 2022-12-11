(module Lang.LSP
  {autoload {lspconfig lspconfig}
   autoload {a aniseed.core}
   autoload {idris idris2}
   autoload {navic nvim-navic}
   autoload {cmp-lsp cmp_nvim_lsp}})

(tset (require :lspconfig.configs) :fennel_language_server
      {:default_config {:cmd [:/home/truff/.cargo/bin/fennel-language-server]
                        :filetypes [:fennel]
                        :single_file_support true
                        :root_dir (lspconfig.util.root_pattern :fnl)
                        :settings {:fennel {:workspace {:library (vim.api.nvim_list_runtime_paths)}
                                            :diagnostics {:globals [:vim]}}}}})

(def- capabilities (cmp-lsp.default_capabilities (vim.lsp.protocol.make_client_capabilities)))
(def- servers [ "bashls" "ccls" "cmake" "html" "idris2_lsp" "pyright" "rls" "sumneko_lua" "tsserver" "rnix" "fennel_language_server"])

(each [_ server (ipairs servers)]
  ((. (. lspconfig server) :setup)
   {:capabilities capabilities
    :on_attach (fn [client bufnr]
                 (navic.attach client bufnr))}))



(lspconfig.html.setup 
  {:capabilities capabilities
   :on_attach (fn [client bufnr]
                 (navic.attach client bufnr))
   :cmd ["html-languageserver" "--stdio"]})

(lspconfig.hls.setup 
  {:capabilities capabilities
   :on_attach (fn [client bufnr]
                (navic.attach client bufnr))
   :cmd ["haskell-language-server" "--lsp"]})

(vim.diagnostic.config 
  {:virtual_text false
   :signs true
   :float 
    {:focusable false
     :style :minimal
     :border :rounded
     :source :always}})
      
(def- signs
  {:DiagnosticSignError ""
   :DiagnosticSignWarn  ""
   :DiagnosticSignHint  ""
   :DiagnosticSignInfo  ""})

(each [diag-type icon (pairs signs)]
    (vim.fn.sign_define diag-type 
                        {:text icon 
                         :texthl diag-type 
                         :numhl diag-type}))

(tset vim.lsp.handlers "textDocument/hover"
      (vim.lsp.with vim.lsp.handlers.hover {:border :rounded}))  

(tset vim.lsp.handlers "textDocument/signatureHelp" 
     (vim.lsp.with vim.lsp.handlers.signature_help {:border :rounded}))

