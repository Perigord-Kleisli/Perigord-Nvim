(module nvim-config 
  {autoload {alpha alpha}
   require {Options Options}
   require {Mapping Mapping}})

; Searches bind from registered which-key bindings
(defn- button [bind icon extra-text]
  (match (Mapping.get-action bind)
    nil (print (.. "Bind: '" (table.concat bind) "' Not Found"))
    [cmd text] {:type :button 
                :val (..  icon "  " (or (and extra-text (. extra-text 1)) "") 
                         text (or (and extra-text (. extra-text 2)) ""))
                :on_press (fn [] 
                            (vim.api.nvim_feedkeys 
                              (vim.api.nvim_replace_termcodes (.. cmd "<Ignore>") true false true)
                              "normal" false)) 
                :opts {:position :center
                       :shortcut (table.concat bind " ") 
                       :align_shortcut :right
                       :hl :Conditional
                       :hl_shortcut :Keyword
                       :cursor 2
                       :width 50 
                       :keymap [ :n (table.concat bind) (.. cmd "<CR>") {:noremap true :silent true :nowait true}]}}))

(set-forcibly! scandir (fn [directory]
                         (do
                           (var (i t popen) (values 0 {} io.popen))
                           (local pfile (popen (.. "ls -a \"" directory "\"")))
                           (each [filename (pfile:lines)]
                             (set i (+ i 1))
                             (tset t i filename))
                           (pfile:close)
                           t)))  


(let [header [
              "       -\\         '-                                                                         "
              "     -' :\\        | '-                                                                       "
              "   -'   : \\       |   '-                          |MMM|                                      "
              " -'·    :  \\      |     '-                        |WWW|                                      "
              "'.-.·   :   \\     |       |                                                                  "
              "|. .-·  :    \\    |       |    MMM=         =MMM  |MMM|  |M|  +===+   +====+                  "
              "| . .-··:     \\   |       |    \\HHB`       'BHH/  |HHH|  |H|\\/sMMMs\\_/sMMMMs\\             "
              "|. . .-·;      \\  |       |     \\HHH\\     /HHH/   |HHH|  |HBBWWWWWHMMMHWWWW:B\\             "
              "| . . .-|       \\ |       |      \\HHH\\   /HHH/    |HHH|  |HK/     \\KYK/    \\KH|           "
              "|. . . .|\\       \\|       |       \\HHH\\ /HHH/     |HHH|  |H|       |H|      |H|            "
              "| . . . | \\       ;-      |        \\HHHVHHH/      |HHH|  |H|       |H|      |H|              "
              "|. . . .|  \\      :·-     |         \\HHHHH/       |HHH|  |H|       |H|      |H|              "
              "| . . . |   \\     : .-    |          \\HHH/        |HHH|  |H|       |H|      |H|              "
              "|. . . .|    \\    :. .-   |           \\W/         |WWW|  |W|       |W|      |W|              "
              "`- . . .|     \\   : . .- -'                                                                  "
              "  `- . .|      \\  :. ..-'                                                                    "
              "    `-. |       \\ :..-'                                                                      "
              "       `|        \\;-'                                                                        "]

      
      in-session-dir 
              (let [cwd (.. (: (vim.fn.getcwd) :gsub :/ "%%") ".vim")]
                (var out false)
                (each [_ file (ipairs (scandir (.. (vim.fn.stdpath "data") "/sessions")))]
                  (if out (lua "break"))
                  (set out (= cwd file)))
                out)

      buttons [
               (if in-session-dir
                 (button [:<space> :o :S] :)
                 (button [:<space> :o :l] :))
               (button [:<space> :f :r] :)
               (button [:<space> :p :p] :)
               (button [:<space> :o :P] :)
               (button [:<space> :<space>] :)
               (button [:<space> :f :t] : ["Find "])
               {:type :padding :val 1}
               {:type :text :val (.. "CWD: " (vim.fn.getcwd)) :opts {:position :center :hl :Comment}}
               {:type :padding :val 2}
               {:type :button 
                   :val "    "
                   :on_press (fn [] (vim.cmd ":!xdg-open \"https://github.com/Trouble-Truffle/Perigord-Nvim\"")) 
                   :opts {:hl :CursorLineNr
                          :position :center
                          :cursor 2
                          :width 50}}]]
      
      
  ((. alpha :setup) 
   {:layout 
      [{:type :padding :val 2} 
       {:type :text :val header :opts {:position :center :hl :diffnewfile}}
       {:type :padding :val 2} 
       {:type :group :val buttons :opts {:spacing 1}}
       {:type :text :val "" :opts {:position :center :hl :Number}}
       github-repo]
       
        
    :opts {:margin 5}}))

(set vim.opt.termguicolors true)
