(local strlen (. (require :plenary.strings) :strdisplaywidth))

(fn assoc [t k v]
  (tset t k v)
  t)

(fn rename-key [from to x]
  (let [val (. x from)]
    (tset x from nil)
    (tset x to val)
    x))

{: strlen : assoc : rename-key}
