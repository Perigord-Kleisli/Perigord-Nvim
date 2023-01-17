(local toggleterm (require :toggleterm))
(toggleterm.setup)
(local Terminal (. (require :toggleterm.terminal) :Terminal))

{:btop (Terminal:new {:cmd :btop :hidden true :direction :float})}
