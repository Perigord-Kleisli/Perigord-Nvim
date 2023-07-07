(local luasnip (require :luasnip))
(local cmp (require :cmp))

(local kind-icons {:Text "󰊄"
                   :Method ""
                   :Function "󰊕"
                   :Constructor ""
                   :Field ""
                   :Variable ""
                   :Class ""
                   :Interface ""
                   :Module ""
                   :Property ""
                   :Unit ""
                   :Value ""
                   :Enum ""
                   :Keyword ""
                   :Snippet ""
                   :Color ""
                   :File ""
                   :Reference ""
                   :Folder ""
                   :EnumMember ""
                   :Constant ""
                   :Struct ""
                   :Event ""
                   :Operator ""
                   :TypeParameter ""})

(local kind-menu {:nvim_lsp "[LSP]"
                  :luasnip "[Snippet]"
                  :calc "[Calc]"
                  :cmp_tabnine "[AI]"
                  :greek "[Greek]"
                  :latex_symbols "[Symbol]"
                  :nerdfont "[Nerdfont]"
                  :emoji "[Emoji]"
                  :rg "[Ripgrep]"
                  :fonts "[Font]"
                  :treesitter "[TS]"
                  :buffer "[File]"
                  :path "[Path]"})

(local {: rename-key} (require :Utils))

((. (require :luasnip.loaders.from_vscode) :lazy_load))
(cmp.setup {:snippet {:expand (fn [args]
                                (luasnip.lsp_expand (. args :body)))}
            :sources (cmp.config.sources [{:name :nvim_lsp}
                                          {:name :luasnip}
                                          {:name :nvim_lua}
                                          {:name :treesitter :keyword_length 2}
                                          {:name :path}
                                          {:name :calc}
                                          {:name :crates}
                                          {:name :rg :keyword_length 5}
                                          {:name :buffer :keyword_length 4}
                                          {:name :nerdfont}
                                          {:name :latex_symbols}
                                          {:name :emoji}
                                          {:name :fonts
                                           :keyword_length 5
                                           :option {:space_filter "-"}}])
            :mapping {:<C-k> (cmp.mapping.select_prev_item)
                      :<C-j> (cmp.mapping.select_next_item)
                      :<C-e> (cmp.mapping.abort)
                      :<C-d> (cmp.mapping (cmp.mapping.scroll_docs 1) [:i :c])
                      :<C-u> (cmp.mapping (cmp.mapping.scroll_docs -1) [:i :c])
                      :<CR> (cmp.mapping.confirm {:select true})}
            :window {:documentation (cmp.config.window.bordered {:winhighlight "FloatBorder:VisualNOS"})}
            :sorting {:comparators [cmp.config.compare.offset
                                    cmp.config.compare.exact
                                    cmp.config.compare.score
                                    cmp.config.compare.kind
                                    cmp.config.compare.sort_text
                                    cmp.config.compare.length
                                    cmp.config.compare.order]}
            :formatting {:fields [:kind :abbr :menu]
                         :format (fn [entry vim-item]
                                   (set vim-item.kind
                                        (. kind-icons vim-item.kind))
                                   (set vim-item.menu
                                        (. kind-menu entry.source.name))
                                   vim-item)}
            :experimental {:ghost_text true}})

(local cmd-mapping (->> (cmp.mapping.preset.cmdline)
                        (rename-key :<C-P> :<C-k>)
                        (rename-key :<C-N> :<C-j>)))

(cmp.setup.cmdline ":" {:sources (cmp.config.sources [{:name :path}
                                                      {:name :cmdline
                                                       :option {:ignore_cmds [:Man
                                                                              "!"]}}])
                        :mapping cmd-mapping})

(cmp.setup.cmdline ":%s"
                   {:sources (cmp.config.sources [{:name :path}
                                                  {:name :cmdline
                                                   :option {:ignore_cmds [:Man
                                                                          "!"]}}])}
                   :mapping cmd-mapping)

(cmp.setup.cmdline "/" {:sources (cmp.config.sources [{:name :treesitter}
                                                      {:name :buffer}])
                        :mapping cmd-mapping})

(local utils (require :Utils))
(local chatgpt (require :chatgpt))
(chatgpt.setup {:api_key_cmd (.. "echo -n " utils.secrets.openai-api-key)})
