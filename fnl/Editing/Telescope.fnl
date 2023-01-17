(local telescope (require :telescope))
(local actions (require :telescope.actions))
(telescope.setup {:defaults {:winblend 1
                             :file_ignore_patterns [:__pycache__
                                                    :node_modules
                                                    :.jpg
                                                    :.jpeg
                                                    :.png
                                                    :.ico
                                                    :dist
                                                    :dist-newstyle]
                             :prompt_prefix " "
                             :selection_caret "  "
                             :mappings {:i {:<C-j> actions.move_selection_next
                                            :<C-k> actions.move_selection_previous
                                            :<C-n> actions.cycle_history_next
                                            :<C-p> actions.cycle_history_prev}}}})

(telescope.load_extension :hoogle)
