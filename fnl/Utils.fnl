(local secrets
       (let [filepath (.. (vim.fn.stdpath :config) :/secrets.json)]
         (let [f (io.open filepath :r)]
           (when (= f nil)
             (with-open [file (io.open filepath :w+)]
               (var M {})
               (tset M :openai-api-key (vim.fn.input "OpenAI api key: "))
               (file:write (vim.fn.json_encode M)))))
         (vim.fn.json_decode (vim.fn.readfile filepath))))

(fn assoc [t k v]
  (tset t k v)
  t)

(fn rename-key [from to x]
  (let [val (. x from)]
    (tset x from nil)
    (tset x to val)
    x))

(lambda get-directory-tree [path]
  (local sep (package.config:sub 1 1))
  (if (= 1 (vim.fn.isdirectory path))
      (icollect [_ dir (ipairs (vim.fn.readdir path))]
        (get-directory-tree (.. path sep dir)))
      [path]))

(lambda flatten [list]
  (local tbl [])
  (each [_ v (ipairs list)]
    (match (type v)
      :table (each [_ w (ipairs (flatten v))]
               (table.insert tbl w))
      _ (table.insert tbl v)))
  tbl)

(fn get-files-recursively []
  (var root-paths (icollect [_ client (ipairs (vim.lsp.buf_get_clients))]
                    (?. client :config :root_dir)))
  (table.insert root-paths (vim.fn.getcwd))
  (set root-paths (icollect [k _ (pairs (collect [_ v (ipairs root-paths)]
                                          (values v 0)))]
                    k))
  (vim.notify (vim.inspect root-paths))
  (-> (icollect [_ v (ipairs root-paths)]
        (get-directory-tree v))
      flatten))

(fn get-executables []
  (icollect [_ v (ipairs (get-files-recursively))]
    (do
      (local mode (?. (vim.loop.fs_stat v) :mode))
      (if (and (not= nil mode) (not= 0 (bit.band mode 9)))
          v
          nil))))

(fn respace-str [str size]
  (let [space (string.rep " " (- size (length str)))]
    (.. str space)))

(fn chunks [arr size]
  (var chunk 1)
  (var idx-in-chunk 1)
  (var out [[]])
  (each [_ v (pairs arr)]
    (tset out chunk idx-in-chunk v)
    (if (= idx-in-chunk size)
        (do
          (table.insert out [])
          (set chunk (+ chunk 1))
          (set idx-in-chunk 1))
        (do
          (set idx-in-chunk (+ 1 idx-in-chunk)))))
  (if (= 0 (table.maxn (. out (table.maxn out))))
      (table.remove out))
  out)

(fn auto-gen-hint [heads name]
  (let [binds-and-desc (collect [_ v (ipairs heads)]
                         (. v 1)
                         (. v 3 :desc))
        max-strlen (accumulate [max 0 k v (pairs binds-and-desc)]
                     (math.max max (length (.. k v))))
        spaced-strs (icollect [k v (pairs binds-and-desc)]
                      (respace-str (.. "_" k "_: " v) (+ 7 max-strlen)))
        name (or name "")]
    (table.sort spaced-strs)
    (.. "  " name ":\n" (-> (icollect [_ v (ipairs (chunks spaced-strs 5))]
                              (.. "    " (table.concat v)))
                            (table.concat "\n")))))

{: assoc
 : rename-key
 : chunks
 : auto-gen-hint
 : secrets
 : get-files-recursively
 : get-directory-tree
 : get-executables
 : flatten}
