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
      
(macro keymap [cmd name] '[(.. "<cmd>" ,cmd "<cr>") ,name])
(macro telescope [cmd theme?] '(.. "Telescope " 
                                  ,cmd 
                                  (or 
                                    (and ,theme? (.. " theme=" ,theme?))
                                    "")))

(macro gitsigns [cmd] '(.. "lua require('gitsigns')." ,cmd "()"))
(macro dap [cmd] '(.. "lua require('dap')." ,cmd "()"))
(macro dap-ui [mod cmd] '(.. "lua require('dap.ui." ,mod "')." ,cmd "()"))
(macro unmap [bind] '(vim.api.nvim_set_keymap "" ,bind :<Nop> {:noremap true :silent true}))
(macro vim-lsp [cmd] '(.. "lua vim.lsp.buf." ,cmd "()"))
(macro mapping [cmd] '(.. "lua require('Mapping')." ,cmd "()"))
(macro toggleterm [cmd opts] 
   '(string.format 
       "lua require('toggleterm.terminal').Terminal:new({%s %s}):toggle()"
       (or (and ,cmd (.. "cmd='" ,cmd "',")) "")
       (or ,opts "hidden=true, direction='float'")))

(macro fallback [cmd-name cmd1 cmd2]
  `(defn ,cmd-name [] (Func.maybe
                        (Func.alternative ,cmd1 ,cmd2 nil)
                        (print "No fallback for " ,cmd-name))))

(fallback
  definition
  vim.lsp.buf.definition
  tsref-navigation.goto_definition)

(fallback
  symbol_search
  telescope-builtin.lsp_document_symbols
  telescope-builtin.treesitter)

(fallback
  rename
  vim.lsp.buf.rename
  tsref-rename.smart_rename)

(legendary.setup)

    
(which-key.register
  {:<C-x> {:name "Comment"
           ";" (keymap "call nerdcommenter#Comment('i','toggle')" "Line")
           :b (keymap "lua require('nvim-comment-frame').add_multiline_comment" "Box")}
   :<A-s> (keymap :ISwapWith "Swap")

   ;:<C-l> (keymap :nohl "Unhighlight Matches")

   :<C-Up> (keymap "call animate#window_delta_height(10)" "Vertical Upsize")
   :<C-A-j> (keymap "call animate#window_delta_height(10)" "Vertical Upsize")

   :<C-Down> (keymap "call animate#window_delta_height(-10)" "Vertical Downsize")
   :<C-A-k> (keymap "call animate#window_delta_height(-10)" "Vertical Downsize")


   :<C-Left> (keymap "call animate#window_delta_width(10)" "Horizontal Upsize")
   :<C-A-l> (keymap "call animate#window_delta_width(10)" "Horizontal Upsize")

   :<C-Right> (keymap "call animate#window_delta_width(-10)" "Horizontal Downsize")
   :<C-A-h> (keymap "call animate#window_delta_width(-10)" "Horizontal Downsize")

   :<A-j> (keymap "m +1" "Move Line Upwards")
   :<A-k> (keymap "m -2" "Move Line Downwards")

   :<C-P> (keymap :Legendary "Command Palette")

   :<A-x> (keymap "bdelete! %" "Delete Buffer")
   :<A-h> (keymap :BufferLineCyclePrev "Previous Buffer")
   :<A-l> (keymap :BufferLineCycleNext "Next Buffer")
   :<A-H> (keymap :BufferLineMovePrev "Previous Buffer")
   :<A-L> (keymap :BufferLineMoveNext "Next Buffer")
   
   :K (keymap (vim-lsp :hover) "Show Symbol Info")

   :g {:name "Go To"
       :b (keymap :BufferLinePick "Buffer")
       :d (keymap (mapping :definition) "Definition")
       :i (keymap (vim-lsp :implementation) "Implementation")
       :t (keymap :BufferLineMovePrev "Previous Buffer")
       :T (keymap :BufferLineMoveNext "Next Buffer")
       "]" (keymap "lua vim.diagnostic.goto_next()" "Next Diagnostic")
       "[" (keymap "lua vim.diagnostic.goto_prev()" "Previous Diagnostic")}})
  
(def- norm-binds
  {:<leader> (keymap (telescope :find_files) "Find Files")
   :d {:name "Debug"
       :b (keymap (dap :toggle_breakpoint) "Toggle Breakpoint")
       :B (keymap "lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))" "Set Conditional Breakpoint")
       :<A-b> (keymap "lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log Point Messsage: '))" "Set Logpoint")
       :l (keymap (dap :step_into) "Step Into")
       :p (keymap (telescope "dap list_breakpoints") "List Breakpoints")
       :f (keymap (telescope "dap frames") "Frames")
       :h (keymap (dap :step_out) "Step Out")
       :r (keymap (dap :repl.open) "Open REPL")
       :n (keymap (dap :continue) "Continue")
       :_ (keymap (dap :run_last) "Run Last")}
       ;:i (keymap (dap-ui :variables :visual_hover) "Visual Hover")
       ;:? (keymap (dap-ui :variables :scopes) "Variable Scopes")}


   :f {:name "Find"
        :f (keymap (telescope :find_files) "Find File")
        :m (keymap (telescope :media_files) "Find Media Files")
        :r (keymap (telescope :oldfiles) "Recently Opened Files")
        :t (keymap (telescope :live_grep :ivy) "Text")
        :s (keymap (mapping :symbol_search) "Document Symbols")}
   :p {:name "Project"
        :p (keymap (telescope :projects) "Projects")}

   :g {:name "Git" 
        :b (keymap (gitsigns   :blame_line) "Blame")
        :B (keymap (telescope  :git_branches) "Branches")
        :c (keymap (telescope  :git_commits) "Commit History")
        :d (keymap (gitsigns   :diffthis) "Diff")
        :j (keymap (gitsigns   :next_hunk) "Next Hunk")
        :k (keymap (gitsigns   :prev_hunk) "Previous Hunk")
        :l (keymap (toggleterm :lazygit) "Open Lazygit")
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
        :r (keymap (mapping :rename) "Rename")
        :s (keymap (mapping :symbol_search) "Document Symbols")}
   :o {:name "Open"
        :b (keymap (toggleterm :btop "direction = 'float'") "Task Manager")
        :c (keymap "Copilot panel" "Copilot")
        :e (keymap :ene "Empty File")
        :l [ "`1" "Last Opened File"]
        :p (keymap :NvimTreeToggle "File Explorer")
        :P (keymap "Telescope file_browser" "File Browser")
        :s (keymap :RestoreSession "Last Session")
        :t (keymap (toggleterm nil "direction = 'horizontal', size=1") "Terminal")
        :T (keymap (toggleterm nil "direction='float' , float_opts={border='rounded'}") "Floating Terminal") 
        :v (keymap (.. (toggleterm nil "direction='vertical'")
                       "; vim.api.nvim_command('call animate#window_percent_width(0.5)')")
                   "Vertical Terminal")
        :z (keymap :ZenMode "Zen Mode")}
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
   :<DOWN> [":m '>+1<CR>gv=gv" "Move Selected Lines Downwards"]
   :<A-j> [":m '>+1<CR>gv=gv" "Move Selected Lines Downwards"]


   :<UP> [":m '<-2<CR>gv=gv" "Move Selected Lines Downwards"]
   :<A-k> [":m '<-2<CR>gv=gv" "Move Selected Lines Downwards"]

   "<C-x>;" ["<Plug>NERDCommenterToggle" "Comment Selection"]

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

