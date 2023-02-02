(fn button [bind label]
  {:type :button
   :val label
   :on_press (-> bind
                 (vim.api.nvim_replace_termcodes true false true)
                 (vim.api.nvim_feedkeys :t false))
   :opts {:position :center
          :shortcut bind
          :align_shortcut :right
          :hl :Conditional
          :hl_shortcut :Keyword
          :cursor 2
          :width 50}})

(vim.api.nvim_set_hl 0 :DashboardHeader {:fg "#8AFF80"})
(vim.api.nvim_set_hl 0 :DashboardKey {:fg "#FF9580"})
(vim.api.nvim_set_hl 0 :DashboardDesc {:fg "#87FEF8"})
(vim.api.nvim_set_hl 0 :DashboardIcon {:fg "#FCFC7F" :bold true})
(vim.api.nvim_set_hl 0 :DashboardFooter {:fg "#5D5D65"})

(let [header ["                                                                                                "
              "                                                                                                "
              "                                                                                                "
              "                                                                                                "
              "                                                                                                "
              "         -\\         '-                                                                         "
              "       -' :\\        | '-                                                                       "
              "     -'   : \\       |   '-                          |MMM|                                      "
              "   -'·    :  \\      |     '-                        |WWW|                                      "
              "  '.-.·   :   \\     |       |                                                                  "
              "   |. .-·  :    \\    |       |    MMM=         =MMM  |MMM|  |M|  +===+   +====+                  "
              "| . .-· :     \\   |       |    \\HHB`       'BHH/  |HHH|  |H|\\/sMMMs\\_/sMMMMs\\             "
              "|. . .-·;      \\  |       |     \\HHH\\     /HHH/   |HHH|  |HBBWWWWWHMMMHWWWW:B\\             "
              "| . . .-|       \\ |       |      \\HHH\\   /HHH/    |HHH|  |HK/     \\KYK/    \\KH|           "
              "|. . . .|\\       \\|       |       \\HHH\\ /HHH/     |HHH|  |H|       |H|      |H|            "
              "  | . . . | \\       ;-      |        \\HHHVHHH/      |HHH|  |H|       |H|      |H|              "
              "  |. . . .|  \\      :·-     |         \\HHHHH/       |HHH|  |H|       |H|      |H|              "
              "  | . . . |   \\     : .-    |          \\HHH/        |HHH|  |H|       |H|      |H|              "
              "  |. . . .|    \\    :. .-   |           \\W/         |WWW|  |W|       |W|      |W|              "
              "  `- . . .|     \\   : . .- -'                                                                  "
              "    `- . .|      \\  :. ..-'                                                                    "
              "      `-. |       \\ :..-'                                                                      "
              "         `|        \\;-'                                                                        "
              "                                                                                                "
              "                                                                                                "]
      {:setup db} (require :dashboard)
      lazy (require :lazy)]
  (db {:theme :doom
       :config {: header
                :center [{:icon "  "
                          :desc :Sessions
                          :key :s
                          :action (. (require :Mapping) :sessions)}
                         {:icon "  "
                          :desc "Recent files"
                          :key :r
                          :action "Telescope oldfiles"}
                         {:icon "  "
                          :desc "Find File"
                          :key :f
                          :action "Telescope find_files"}
                         {:icon "  "
                          :desc "Find Text"
                          :key :t
                          :action "Telescope live_grep"}
                         {:icon "  "
                          :desc "(WIP) mappings"
                          :key "?"
                          :action #(vim.notify "Guide is still WIP" :error)}
                         {:icon "  "
                          :desc "Assasinate a political figure"
                          :key :K
                          :action #(vim.notify :bang! :error)}
                         {:icon "  "
                          :desc "Check health"
                          :key :H
                          :action :checkhealth}]
                :footer [(.. "Current Directory: " (vim.fn.getcwd))
                         ""
                         ""
                         ""
                         (.. "Loaded " (tostring (. (lazy.stats) :loaded))
                             " plugins in "
                             (tostring (math.floor (. (lazy.stats) :times
                                                      :LazyDone)))
                             :ms)]}}))
