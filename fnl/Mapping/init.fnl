(set vim.g.mapleader " ")
(set vim.o.mouse :a)

(local hydra (require :hydra))

(local cmd (. (require :hydra.keymap-util) :cmd))
(macro cmd-tele [command]
  (.. "<CMD>Telescope " command :<CR>))

(vim.api.nvim_set_keymap :t :<Esc> "<C-\\><C-n>"
                         {:noremap true :silent true :desc "Exit terminal"})

(vim.api.nvim_set_keymap :n :<leader><leader> (cmd-tele :find_files)
                         {:noremap true :silent true :desc "Browse Files"})

(vim.api.nvim_set_keymap :n :<leader><leader> (cmd-tele :find_files)
                         {:noremap true :silent true :desc "Browse Files"})

(vim.api.nvim_set_keymap :v :<C-c> "\"+y"
                         {:silent false :desc "Copy to system clipboard"})

(vim.api.nvim_set_keymap :v :<DOWN> ":m '>+1<CR>gv=gv<CR>"
                         {:noremap true
                          :silent true
                          :desc "Move Selected Lines Downwards"})

(vim.api.nvim_set_keymap :v :<A-j> ":m '>+1<CR>gv=gv<CR>"
                         {:noremap true
                          :silent true
                          :desc "Move Selected Lines Downwards"})

(vim.api.nvim_set_keymap :v :<UP> ":m '<-2<CR>gv=gv<CR>"
                         {:noremap true
                          :silent true
                          :desc "Move Selected Lines Upwards"})

(vim.api.nvim_set_keymap :v :<A-k> ":m '<-2<CR>gv=gv<CR>"
                         {:noremap true
                          :silent true
                          :desc "Move Selected Lines Upwards"})

(vim.api.nvim_set_keymap :n :<C-Up> ":resize +3<CR>"
                         {:noremap true :silent true :desc "Vertical Resize+"})

(vim.api.nvim_set_keymap :n :<C-Down> ":resize -3<CR>"
                         {:noremap true :silent true :desc "Vertical Resize-"})

(vim.api.nvim_set_keymap :n :<C-Left> ":vertical resize +3<CR>"
                         {:noremap true
                          :silent true
                          :desc "Horizontal Resize+"})

(vim.api.nvim_set_keymap :n :<C-Right> ":vertical resize -3<CR>"
                         {:noremap true
                          :silent true
                          :desc "Horizontal Resize-"})

(vim.api.nvim_set_keymap :n :<A-j> ":m +1<CR>"
                         {:noremap true :silent true :desc "Move Line Upwards"})

(vim.api.nvim_set_keymap :n :gh :^
                         {:noremap true :silent true :desc "Go to line start"})

(vim.api.nvim_set_keymap :n :gl :$
                         {:noremap true :silent true :desc "Go to line end"})

(vim.api.nvim_set_keymap :n :<A-k> ":m -2<CR>"
                         {:noremap true
                          :silent true
                          :desc "Move Line Downwards"})

(vim.api.nvim_set_keymap :t :<leader>ot :<cmd>ToggleTerm<CR>
                         {:noremap true :silent true :desc "Toggle Terminal"})

(vim.api.nvim_set_keymap :n :U :<cmd>UndotreeToggle<CR>
                         {:noremap true :silent true :desc "Toggle undotree"})

(hydra {:name :Browse/Open
        :mode :n
        :config {:invoke_on_body true :foreign_keys :run :type :statusline}
        :body :<leader>o
        :heads [[:p (cmd :NvimTreeToggle) {:desc :Sidebar :exit true}]
                [:t (cmd :ToggleTerm) {:desc :Terminal :exit true}]
                [:r (cmd-tele :oldfiles) {:desc "Recent Files" :exit true}]
                [:h (cmd :BufferLineCyclePrev) {:desc "Previous Buffer"}]
                [:l (cmd :BufferLineCycleNext) {:desc "Next Buffer"}]
                [:<esc> nil {:desc :Exit :exit true}]]})

(require :Mapping.Tabs)
(require :Mapping.Lang)
(require :Mapping.Debug)
