(vim.keymap.set :t :<Esc> "<C-\\><C-n>"
                {:noremap true :silent true :desc "Exit terminal"})

(vim.keymap.set :v :<C-c> "\"+y"
                {:silent false :desc "Copy to system clipboard"})

(vim.keymap.set :n :<C-Up> ":resize +3<CR>"
                {:noremap true :silent true :desc "Vertical Resize+"})

(vim.keymap.set :n :<C-Down> ":resize -3<CR>"
                {:noremap true :silent true :desc "Vertical Resize-"})

(vim.keymap.set :n :<C-Left> ":vertical resize +3<CR>"
                {:noremap true :silent true :desc "Horizontal Resize+"})

(vim.keymap.set :n :<C-Right> ":vertical resize -3<CR>"
                {:noremap true :silent true :desc "Horizontal Resize-"})

(vim.keymap.set [:n :o :x :v] :gh "^"
                {:noremap true :silent true :desc "Go to line start"})

(vim.keymap.set [:n :o :x :v] :gl "$"
                {:noremap true :silent true :desc "Go to line end"})

(vim.keymap.set :t :<leader>ot :<cmd>ToggleTerm<CR>
                {:noremap true :silent true :desc "Toggle Terminal"})

(vim.keymap.set :n :<C-l> :<cmd>nohl<CR>
                {:noremap true :silent true :desc "Toggle Terminal"})

(vim.keymap.set :n :U :<cmd>UndotreeToggle<CR>
                {:noremap true :silent true :desc "Toggle undotree"})

(let [{: new} (require :nvim-possession)]
  (vim.keymap.set [:n :x :o] :<C-s> new {:noremap true :desc "Make Session"}))

(let [leap (require :leap)]
  (vim.keymap.set [:n :x :o] :s #(leap.leap [])
                  {:noremap true :silent true :desc "Leap forwards"})
  (vim.keymap.set [:n :x :o] :S #(leap.leap {:backward true})
                  {:noremap true :silent true :desc "Leap backwards"}))

(local {:register wk} (require :which-key))
(local telescope (require :telescope.builtin))

(local {: cmd} (require :hydra.keymap-util))
(local {: Terminal} (require :toggleterm.terminal))
(local btop (Terminal:new {:cmd :btop :direction :float}))

(fn sessions-telescope [opts]
  (let [pickers (require :telescope.pickers)
        finders (require :telescope.finders)
        actions (require :telescope.actions)
        previewers (require :telescope.previewers)
        action-state (require :telescope.actions.state)
        {: load} (require :nvim-possession)
        session-dir (.. (vim.fn.stdpath :data) :/sessions)
        {:values conf} (require :telescope.config)]
    (local opts (or opts []))

    (fn attach_mappings [prompt-buf# _map]
      (actions.select_default:replace (fn []
                                        (actions.close prompt-buf#)
                                        (local selection
                                               (action-state.get_selected_entry))
                                        (load selection)))
      true)

    (fn define_preview [self entry status]
      (var display [:Files])
      (var curdir "")
      (var opened-buffers [])
      (var currently-open "")
      (each [line (io.lines (.. session-dir "/" entry.value))]
        (match (string.match line "^cd%s*(.*)$")
          nil nil
          x (set curdir x))
        (match (string.match line "^badd%s+[+]%d*%s+(.*)$")
          nil nil
          x (table.insert opened-buffers x))
        (match (string.match line "^edit%s+(.*)$")
          nil nil
          x (set currently-open x)))
      (local indent (string.rep " " vim.o.shiftwidth))
      (var display ["Working directory: "
                    (.. indent curdir)
                    ""
                    "Focused buffer: "
                    (.. indent currently-open)
                    ""
                    "Open buffers: "])
      (table.foreach opened-buffers
                     #(table.insert display
                                    (.. indent
                                        (string.gsub $2 (.. curdir "/?") ""))))
      (vim.api.nvim_buf_set_option self.state.bufnr :filetype :yaml)
      (vim.api.nvim_buf_set_lines self.state.bufnr 0 -1 false display)
      (set self.state.last_set_bufnr self.state.bufnr))

    (local dir (vim.loop.fs_opendir session-dir))
    (local results (icollect [_ {: name} (ipairs (vim.loop.fs_readdir dir))]
                     name))
    (dir:closedir)
    (local color-picker
           (pickers.new opts {:prompt_title :Sessions
                              :finder (finders.new_table {: results})
                              :sorter (conf.generic_sorter opts)
                              :previewer (previewers.new_buffer_previewer {:title "Session Info"
                                                                           : define_preview})
                              : attach_mappings}))
    (color-picker:find)))

(local sessions #(sessions-telescope ((. (require :telescope.themes)
                                         :get_dropdown))))

(wk {:o {:name :Open
         :p [(cmd :NvimTreeToggle) :Sidebar]
         :t [(cmd :ToggleTerm) :Terminal]
         :s [sessions :Session]
         :T [(cmd "ToggleTerm direction=float") "Floating Terminal"]
         :n [(cmd "Telescope notify") "Recent Notifications"]
         :b [#(btop:toggle) "Task Manager"]
         :r [telescope.oldfiles "Recent Files"]}
     :f {:name :Find :t [telescope.live_grep :Text]}
     :<leader> [telescope.find_files "Browse Files"]} {:prefix :<leader>})

(require :Mapping.Buffers)
(require :Mapping.Lang)

{: sessions}
