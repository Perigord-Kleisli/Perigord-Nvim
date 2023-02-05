(local Hydra (require :hydra))
(local gitsigns (require :gitsigns))
(local hint " _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^
 ^ ^              _<Enter>_: Neogit              _q_: exit
")

(fn on_attach [bufnr]
  (Hydra {:name :+Git
          : hint
          :config {:buffer bufnr
                   :color :pink
                   :invoke_on_body true
                   :hint {:border :rounded}
                   :on_enter (fn []
                               (vim.cmd :mkview)
                               (vim.cmd "silent! %foldopen!")
                               (set vim.bo.modifiable false)
                               (gitsigns.toggle_signs true)
                               (gitsigns.toggle_linehl true))
                   :on_exit (fn []
                              (local cursor-pos (vim.api.nvim_win_get_cursor 0))
                              (vim.cmd :loadview)
                              (vim.api.nvim_win_set_cursor 0 cursor-pos)
                              (vim.cmd "normal zv")
                              (gitsigns.toggle_signs false)
                              (gitsigns.toggle_linehl false)
                              (gitsigns.toggle_deleted false))}
          :mode [:n :x]
          :body :<leader>g
          :heads [[:J
                   (fn []
                     (when vim.wo.diff
                       (lua "return \"]c\""))
                     (vim.schedule (fn []
                                     (gitsigns.next_hunk)))
                     :<Ignore>)
                   {:expr true :desc "next hunk"}]
                  [:K
                   (fn []
                     (when vim.wo.diff
                       (lua "return \"[c\""))
                     (vim.schedule (fn []
                                     (gitsigns.prev_hunk)))
                     :<Ignore>)
                   {:expr true :desc "prev hunk"}]
                  [:s
                   ":Gitsigns stage_hunk<CR>"
                   {:silent true :desc "stage hunk"}]
                  [:u gitsigns.undo_stage_hunk {:desc "undo last stage"}]
                  [:S gitsigns.stage_buffer {:desc "stage buffer"}]
                  [:p gitsigns.preview_hunk {:desc "preview hunk"}]
                  [:d
                   gitsigns.toggle_deleted
                   {:nowait true :desc "toggle deleted"}]
                  [:b gitsigns.blame_line {:desc :blame}]
                  [:B
                   (fn []
                     (gitsigns.blame_line {:full true}))
                   {:desc "blame show full"}]
                  ["/" gitsigns.show {:exit true :desc "show base file"}]
                  [:<Enter> :<Cmd>Neogit<CR> {:exit true :desc :Neogit}]
                  [:q nil {:exit true :nowait true :desc :exit}]]}))

(gitsigns.setup {: on_attach})
