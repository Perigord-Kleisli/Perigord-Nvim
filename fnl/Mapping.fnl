(module Mapping
  {autoload {which-key which-key}
   autoload {Func Functions}
   autoload {legendary legendary}
   autoload {tsref-navigation nvim-treesitter-refactor.navigation}
   autoload {tsref-rename nvim-treesitter-refactor.smart_rename}
   autoload {telescope-builtin telescope.builtin}
   autoload {telescope-themes telescope.themes}
   autoload {a aniseed.core}})


(set vim.g.mapleader " ")

(defn newFile []
  (vim.ui.input
    {:prompt "File Name: "
     :default (match (vim.fn.expand "%:e")
                "" ""
                ext (.. "." ext))}
    (fn [input]
      (vim.api.nvim_command (.. "edit " input)))))

(macro keymap [cmd name] '[(.. "<cmd>" ,cmd "<cr>") ,name])
(macro telescope [cmd theme?] '(string.format "Telescope %s %s"
                                              ,cmd
                                              ,(if theme? (.. "theme=" theme?) "")))

(macro gitsigns [cmd] '(.. "lua require('gitsigns')." ,cmd "()"))
(macro dap [cmd] '(.. "lua require('dap')." ,cmd "()"))
(macro dap-ui [mod cmd] '(.. "lua require('dap.ui." ,mod "')." ,cmd "()"))
(macro unmap [bind] '(vim.api.nvim_set_keymap "" ,bind :<Nop> {:noremap true :silent true}))
(macro vim-lsp [cmd] '(.. "lua vim.lsp.buf." ,cmd "()"))
(macro mapping [cmd] '(.. "lua require('Mapping')['" ,cmd "']()"))
(macro toggleterm [cmd opts] 
   '(string.format 
       "lua require('toggleterm.terminal').Terminal:new({%s %s}):toggle()"
       (or (and ,cmd (.. "cmd='" ,cmd "',")) "")
       (or ,opts "hidden=true, direction='float'")))

                 
(defn has-lsp []
  (do
    (each [_ key (ipairs (vim.lsp.buf_get_clients))]
      (if (not (or (= key.name :null-ls) (= key.name :copilot)))
        (lua "return true")))
    false))
    
(macro fallback [cmd-name cmd1 cmd2]
  `(defn ,cmd-name [] (if (has-lsp)
                        (,cmd1)
                        (,cmd2))))

(fallback
  definition
  vim.lsp.buf.definition
  tsref-navigation.goto_definition)

(fallback
  symbol-search
  telescope-builtin.lsp_document_symbols
  telescope-builtin.treesitter)

(fallback
  rename
  vim.lsp.buf.rename
  tsref-rename.smart_rename)

(legendary.setup)

(which-key.register
  {
   :<C-Up> (keymap "call animate#window_delta_height(10)" "Vertical Upsize")
   :<C-A-j> (keymap "call animate#window_delta_height(10)" "Vertical Upsize")

   :<C-Down> (keymap "call animate#window_delta_height(-10)" "Vertical Downsize")
   :<C-A-k> (keymap "call animate#window_delta_height(-10)" "Vertical Downsize")


   :<C-Left> (keymap "call animate#window_delta_width(10)" "Horizontal Upsize")
   :<C-A-l> (keymap "call animate#window_delta_width(10)" "Horizontal Upsize")

   :<C-Right> (keymap "call animate#window_delta_width(-10)" "Horizontal Downsize")
   :<C-A-h> (keymap "call animate#window_delta_width(-10)" "Horizontal Downsize")

   :<C-s> (keymap "w | :SaveSession" "Save Session")

   :<A-s> (keymap "lua require'nvim-treesitter.textobjects.swap'.swap_next('@parameter.inner')" "Swap With Next Parameter")
   :<A-S> (keymap "lua require'nvim-treesitter.textobjects.swap'.swap_previous('@parameter.inner')" "Swap With Previous Parameter")

   :<A-j> (keymap "m +1" "Move Line Upwards")
   :<A-k> (keymap "m -2" "Move Line Downwards")

   :<C-P> (keymap :Legendary "Command Palette")

   :<A-x> (keymap "bdelete! %" "Delete Buffer")
   :<A-h> (keymap :BufferLineCyclePrev "Previous Buffer")
   :<A-l> (keymap :BufferLineCycleNext "Next Buffer")
   :<A-H> (keymap :BufferLineMovePrev "Previous Buffer")
   :<A-L> (keymap :BufferLineMoveNext "Next Buffer")
   
   :K (keymap (vim-lsp :hover) "Show Symbol Info")
   :<A-K> (keymap :DocsViewToggle "Language LSP Documentation")

   :g {:name "Go To"
       :b (keymap :BufferLinePick "Buffer")
       :d (keymap (mapping :definition) "Definition")
       :i (keymap (vim-lsp :implementation) "Implementation")
       :t (keymap :BufferLineMovePrev "Previous Buffer")
       :T (keymap :BufferLineMoveNext "Next Buffer")
       "]" (keymap "lua vim.diagnostic.goto_next()" "Next Diagnostic")
       "[" (keymap "lua vim.diagnostic.goto_prev()" "Previous Diagnostic")}})
  
(def- norm-binds
  {:<leader> [":Telescope find_files<cr>" "Find Files"]
   :c {:name "Comment"
       :b (keymap "lua require('nvim-comment-frame').add_multiline_comment" "Boxed Comment")}
   :d {:name "Debug"
       :b (keymap (dap :toggle_breakpoint) "Toggle Breakpoint")
       :B (keymap "lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))" "Set Conditional Breakpoint")
       :<A-b> (keymap "lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log Point Messsage: '))" "Set Logpoint")
       :h (keymap (dap :step_out) "Step Out")
       :l (keymap (dap :step_into) "Step Into")
       :j (keymap (dap :step_over) "Step Over")
       :k (keymap (dap :step_back) "Step Back")
       :p (keymap (telescope "dap list_breakpoints") "List Breakpoints")
       :f (keymap (telescope "dap frames") "Frames")
       :t (keymap :DapTerminate "Terminate")
       :n (keymap (dap :continue) "Continue")
       :_ (keymap (dap :run_last) "Run Last")
       :u (keymap "lua require'dapui'.toggle()" "Toggle DAP UI")}


   :f {:name "Find"
        :f (keymap (telescope :find_files) "Find File")
        :m (keymap (telescope :media_files) "Find Media Files")
        :r (keymap (telescope :oldfiles) "Recently Opened Files")
        :R (keymap (vim-lsp :references) "Find References")
        :t (keymap (telescope :live_grep :ivy) "Text")
        :s (keymap (mapping :symbol-search) "Document Symbols")}

   :p {:name "Project"
        :p [":Telescope projects<cr>" "Projects"]}

   :g {:name "Git" 
        :b (keymap (gitsigns   :blame_line) "Blame")
        :B (keymap (telescope  :git_branches) "Branches")
        :c (keymap (telescope  :git_commits) "Commit History")
        :d (keymap (gitsigns   :diffthis) "Diff")
        :j (keymap (gitsigns   :next_hunk) "Next Hunk")
        :k (keymap (gitsigns   :prev_hunk) "Previous Hunk")
        :l (keymap (toggleterm :lazygit) "Open Lazygit")
        :n (keymap :Neogit "NeoGit")
        :p (keymap (gitsigns   :preview_hunk) "Preview Diff")
        :R (keymap (gitsigns   :reset_hunk) "Reset Hunk")
        :RR (keymap (gitsigns  :reset_buffer) "Reset Buffer")
        :s (keymap (telescope  :git_status) "Git Status")
        :S (keymap (gitsigns   :stage_hunk) "Stage Hunk")
        :U (keymap (gitsigns   :undo_stage_hunk) "Unstage Hunk")}

   :l {:name "Language" 
        :a (keymap (vim-lsp   :code_action) "Code Action")
        :d (keymap (telescope :diagnostics :ivy) "Diagnostics")
        :f (keymap (vim-lsp   :formatting_sync) "Format")
        :i (keymap :LspInfo "LSP Info")
        :l (keymap "lua vim.diagnostic.open_float()" "Line Diagnostic")
        :L (keymap :LspLog "LSP Log")
        :k (keymap :DocsViewToggle "Language LSP Documentation")
        :r (keymap (mapping :rename) "Rename")
        :R (keymap (vim-lsp :references) "Find References")
        :S (keymap (mapping :symbol_search) "Document Symbols")
        :s {:name "Snippet"
            :s (keymap :SnipRun "Run Snippet")
            :S (keymap :SnipClose "Stop Snippet")
            :t (keymap "lua require'sniprun.live_mode'.toggle()" "Toggle Live Snippet")}
        :u (keymap :RunCode "Run File")
        :U (keymap :RunProject "Run Project")}

   :o {:name "Open"
       :b (keymap (toggleterm :btop "direction = 'float'") "Task Manager")
       :c (keymap "Copilot panel" "Copilot")
       :d (keymap :DocsViewToggle "Language LSP Documentation")
       :e (keymap :ene "Empty File")
       :l [ "`0" "Last Opened File"]
       :n (keymap (mapping :newFile) "New File")
       :p (keymap :NvimTreeToggle "File Explorer")
       :P (keymap "Telescope file_browser" "File Browser")
       :s (keymap :SymbolsOutline "Document Symbol Tree")
       :S (keymap :RestoreSession "Last Session")
       :t (keymap (toggleterm nil "direction = 'horizontal', size=1") "Terminal")
       :T (keymap (toggleterm nil "direction='float' , float_opts={border='rounded'}") "Floating Terminal") 
       :v (keymap (.. (toggleterm nil "direction='vertical'")
                      "; vim.api.nvim_command('call animate#window_percent_width(0.5)')")
                  "Vertical Terminal")
       :Z (keymap :ZenMode "Zen Mode")}

   :P {:name "Packer" 
       :i (keymap :PackerInstall "Install")
       :s (keymap :PackerSync "Sync") 
       :S (keymap :PackerStatus "Status")}})

(which-key.register
  norm-binds
  {:prefix "<leader>"})

(defn- lang-specific-binds [filetype]
  (match filetype
    "markdown" {:<leader>lm (keymap :MarkdownPreview "Preview Markdown")}
    _ {}))

(vim.api.nvim_create_autocmd [:BufEnter :BufRead] 
  {:pattern "*"
   :callback (fn [] (which-key.register (lang-specific-binds vim.bo.filetype)))})
     
(vim.api.nvim_set_keymap :v :<C-c> "\"+y" {:silent false})

(which-key.register 
  {
   :<space>s 
      {:name "Snippet"
       :s (keymap :SnipRun "Run Snippet")
       :S (keymap :SnipClose "Stop Snippet")
       :t (keymap "lua require'sniprun.live_mode'.toggle()" "Toggle Live Snippet")}
   :<space>d
      {:name "Debug"
       :e (keymap "lua require'dapui'.eval()" "Start Debugging")}

   :<DOWN> [":m '>+1<CR>gv=gv" "Move Selected Lines Downwards"]
   :<A-j> [":m '>+1<CR>gv=gv" "Move Selected Lines Downwards"]


   :<UP> [":m '<-2<CR>gv=gv" "Move Selected Lines Downwards"]
   :<A-k> [":m '<-2<CR>gv=gv" "Move Selected Lines Downwards"]

   "<space>c<space>" ["<Plug>NERDCommenterToggle" "Comment Selection"]

   :< [ "<gv" "Unindent"]
   :> [ ">gv" "Indent"]} 

  {:mode :v})
(vim.api.nvim_set_keymap :t :<Esc> :<C-\><C-n> {:silent true})
(vim.api.nvim_set_keymap :t :<Space>ot :<C-\><C-n>:q<CR> {:silent true})
(vim.api.nvim_set_keymap :t :<Space>oT :<C-\><C-n>:q<CR> {:silent true})
(vim.api.nvim_set_keymap :t :<Space>ov :<C-\><C-n>:q<CR> {:silent true})

(set vim.g.copilot_no_tab_map true)
(let [to-leader 
      (fn [key] 
        (if (= vim.g.mapleader (vim.api.nvim_replace_termcodes key true false true))
          "<leader>"
          key))]
  (defn get-action [bind]
    (do
      (var bind-table {:<leader> norm-binds})
      (each [_ key (ipairs bind)] 
        (do
          (if (= bind-table nil) 
              (lua :break))
              
          (set bind-table (. bind-table (to-leader key)))))

      bind-table)))
(vim.api.nvim_create_user_command 
  :W
  ":execute \"SaveSession\" | w"
  {})

(vim.api.nvim_create_user_command 
  :WQ
  ":execute \"SaveSession\" | wqall"
  {})
