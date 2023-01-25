(set vim.g.mapleader " ")
(set vim.o.mouse :a)

(local hydra (require :hydra))

(local cmd (. (require :hydra.keymap-util) :cmd))
(macro cmd-tele [command]
  (.. "<CMD>Telescope " command :<CR>))

(vim.keymap.set :t :<Esc> "<C-\\><C-n>"
                {:noremap true :silent true :desc "Exit terminal"})

(vim.keymap.set :n :<leader><leader> (cmd-tele :find_files)
                {:noremap true :silent true :desc "Browse Files"})

(vim.keymap.set :n :<leader><leader> (cmd-tele :find_files)
                {:noremap true :silent true :desc "Browse Files"})

(vim.keymap.set :v :<C-c> "\"+y"
                {:silent false :desc "Copy to system clipboard"})

(vim.keymap.set :v :<DOWN> ":m '>+1<CR>gv=gv<CR>"
                {:noremap true
                 :silent true
                 :desc "Move Selected Lines Downwards"})

(vim.keymap.set :v :<A-j> ":m '>+1<CR>gv=gv<CR>"
                {:noremap true
                 :silent true
                 :desc "Move Selected Lines Downwards"})

(vim.keymap.set :v :<UP> ":m '<-2<CR>gv=gv<CR>"
                {:noremap true
                 :silent true
                 :desc "Move Selected Lines Upwards"})

(vim.keymap.set :v :<A-k> ":m '<-2<CR>gv=gv<CR>"
                {:noremap true
                 :silent true
                 :desc "Move Selected Lines Upwards"})

(vim.keymap.set :n :<C-Up> ":resize +3<CR>"
                {:noremap true :silent true :desc "Vertical Resize+"})

(vim.keymap.set :n :<C-Down> ":resize -3<CR>"
                {:noremap true :silent true :desc "Vertical Resize-"})

(vim.keymap.set :n :<C-Left> ":vertical resize +3<CR>"
                {:noremap true :silent true :desc "Horizontal Resize+"})

(vim.keymap.set :n :<C-Right> ":vertical resize -3<CR>"
                {:noremap true :silent true :desc "Horizontal Resize-"})

(vim.keymap.set :n :<A-j> ":m +1<CR>"
                {:noremap true :silent true :desc "Move Line Upwards"})

(vim.keymap.set :n :gh "^"
                {:noremap true :silent true :desc "Go to line start"})

(vim.keymap.set :n :gl "$" {:noremap true :silent true :desc "Go to line end"})

(vim.keymap.set :n :<A-k> ":m -2<CR>"
                {:noremap true :silent true :desc "Move Line Downwards"})

(vim.keymap.set :t :<leader>ot :<cmd>ToggleTerm<CR>
                {:noremap true :silent true :desc "Toggle Terminal"})

(vim.keymap.set :n :U :<cmd>UndotreeToggle<CR>
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
(require :Mapping.Actions)
