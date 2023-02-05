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
                          :action #((. (require :telescope) :extensions :sesh :sesh))}
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
                             (tostring (math.floor (. (lazy.stats) :startuptime)))
                             :ms)]}}))
