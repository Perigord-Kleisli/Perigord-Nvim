(module Lang.CodeRunner
  {autoload {code-runner code_runner}})
(code-runner.setup
  {:mode :toggle
   :startInsert true
   :filetype
    {:haskell "cd $dir && runghc $fileName"
     :rust "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt"
     :python "python3 -u"
     :apl "dyalog -script DYALOG_LINEEDITOR_MODE=1"
     :idris2 "idris2 $fileName -o $fileNameWithoutExt && ./build/exec/$fileNameWithoutExt"
     :cpp "cd $dir && c++ $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt"
     :c "cd $dir && cc $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt"}})
