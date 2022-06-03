(module Functions)

(def repl (match vim.bo.filetype
              "lua" "luajit"
              "fennel" "fennel"
              "haskell" "ghci"
              "python" "python"
              "lisp" "sbcl"
              "javascript" "node"
              "nix" "nix repl"
              _ (os.getenv "SHELL")))

(defn alternative [fa fb ...]
  (let [(status-ok result) (pcall fa ...)] 
    (if status-ok 
      result 
      (fb ...))))

(defn maybe [fa b ...]
  (alternative fa (fn [] b) ...))

(set-forcibly! scandir (fn [directory]
                         (do
                           (var (i t popen) (values 0 {} io.popen))
                           (local pfile (popen (.. "ls -a \"" directory "\"")))
                           (each [filename (pfile:lines)]
                             (set i (+ i 1))
                             (tset t i filename))
                           (pfile:close)
                           t)))  

