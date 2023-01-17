(local cmp (require :cmp))
(local luasnip (require :luasnip))
(local crates (require :crates))
(local utils (require :Utils))
(local rename-key (. (require :Utils) :rename-key))

(local kind-icons {:Text ""
                   :Method :m
                   :Function ""
                   :Constructor ""
                   :Field ""
                   :Variable ""
                   :Class ""
                   :Interface ""
                   :Module ""
                   :Property ""
                   :Unit ""
                   :Value ""
                   :Enum ""
                   :Keyword ""
                   :Snippet ""
                   :Color ""
                   :File ""
                   :Reference ""
                   :Folder ""
                   :EnumMember ""
                   :Constant ""
                   :Struct ""
                   :Event ""
                   :Operator ""
                   :TypeParameter ""})

(local kind-menu {:nvim_lsp "[LSP]"
                  :luasnip "[Snippet]"
                  :calc "[Calc]"
                  :greek "[Greek]"
                  :latex_symbols "[Symbol]"
                  :nerdfont "[Nerdfont]"
                  :emoji "[Emoji]"
                  :fonts "[Font]"
                  :treesitter "[TS]"
                  :cmp-clippy "[Clippy]"
                  :buffer "[File]"
                  :path "[Path]"})

(cmp.setup {:snippet {:expand (fn [args]
                                (luasnip.lsp_expand (. args :body)))}
            :sources (cmp.config.sources [{:name :nvim_lsp}
                                          {:name :nvim_lua}
                                          {:name :treesitter :keyword_length 2}
                                          {:name :luasnip}
                                          {:name :path}
                                          {:name :cmp-clippy
                                           :option {:model :EleutherAI/gpt-neo-2.7B
                                                    :key utils.secrets.huggingface-token}}
                                          {:name :calc}
                                          {:name :crates}
                                          {:name :latex_symbols}
                                          {:name :nvim_lsp_signature_help}
                                          {:name :buffer :keyword_length 4}
                                          {:name :fonts
                                           :keyword_length 5
                                           :option {:space_filter "-"}}
                                          {:name :nerdfont}
                                          {:name :emoji}])
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

(crates.setup)
(cmp.setup.cmdline ":" {:sources (cmp.config.sources [{:name :path}
                                                      {:name :cmdline
                                                       :option {:ignore_cmds [:Man
                                                                              "!"]}}])
                        :mapping cmd-mapping})

(local cmp-autopairs (require :nvim-autopairs.completion.cmp))
(cmp.event:on :confirm_done (cmp-autopairs.on_confirm_done))
