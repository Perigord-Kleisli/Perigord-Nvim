(local hydra (require :hydra))

(local cmd (. (require :hydra.keymap-util) :cmd))

(hydra {:name :Buffer
        :mode :n
        :config {:invoke_on_body true}
        :body :<leader>b
        :heads [[:j (cmd :BufferLineCyclePrev) {:desc "Previous Buffer"}]
                [:k (cmd :BufferLineCycleNext) {:desc "Next Buffer"}]
                [:h (cmd :BufferLineMovePrev) {:desc "Move Buffer Left"}]
                [:l (cmd :BufferLineMoveNext) {:desc "Move Buffer Right"}]
                [:x (cmd "bdelete! %") {:desc "Close Buffer"}]]})


(fn map [key action]
  (vim.api.nvim_set_keymap :n key (.. :<CMD> action :<CR>)
                           {:noremap true :silent false}))

;for quick buffer switches
(map :<A-h> :BufferLineCyclePrev)
(map :<A-l> :BufferLineCycleNext)
(map :<A-H> :BufferLineMovePrev)
(map :<A-L> :BufferLineMoveNext)
(map :<A-1> "BufferLineGoToBuffer 1")
(map :<A-2> "BufferLineGoToBuffer 2")
(map :<A-3> "BufferLineGoToBuffer 3")
(map :<A-4> "BufferLineGoToBuffer 4")
(map :<A-5> "BufferLineGoToBuffer 5")
(map :<A-6> "BufferLineGoToBuffer 6")
(map :<A-7> "BufferLineGoToBuffer 7")
(map :<A-8> "BufferLineGoToBuffer 8")
(map :<A-9> "BufferLineGoToBuffer 9")
(map :<A-0> "BufferLineGoToBuffer 0")
(map :<A-p> :BufferLineTogglePin)
(map :<A-x> "bdelete! %")
