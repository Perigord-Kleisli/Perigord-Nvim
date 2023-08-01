(local lspconfig (require :lspconfig))
(local {: capabilities} (require :Lang.LSP))
(local omnisharp-extended (require :omnisharp_extended))
(local pid (vim.fn.getpid))

(lspconfig.omnisharp.setup {:handlers {:textDocument/definition omnisharp-extended.handler}
                            :server {: capabilities}
                            :cmd [:OmniSharp :--languageserver :--hostPID (tostring pid)]})

(vim.cmd.LspStart :omnisharp)
