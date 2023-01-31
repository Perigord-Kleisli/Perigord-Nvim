;; (local iron (require :iron.core))
;; (local iron-view (require :iron.view))
;; (local ht (require :haskell-tools))
;;
;; ;; fnlfmt: skip
;; (iron.setup
;;   {:config
;;     {:repl_definition
;;       {:fennel {:command [:rlwrap :fennel]}
;;        :rust {:command [:evcxr]}
;;        :haskell {:command (fn [meta] (let [file (vim.api.nvim_buf_get_name meta.current_bufnr)]
;;                                        (ht.repl.mk_repl_cmd file)))}}
;;      :repl_open_cmd (iron-view.bottom 20)}})
