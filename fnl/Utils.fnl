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

{ : assoc : rename-key : chunks : auto-gen-hint : secrets}
