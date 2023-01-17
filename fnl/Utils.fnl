(local fennel (require :hotpot.fennel))
(local secrets (let [file (io.open (.. (vim.fn.stdpath :config) :/secrets.json)
                                   :r)]
                 (vim.json.decode (file:read :*a))))

(local strlen (. (require :plenary.strings) :strdisplaywidth))

(fn trace [x ...]
  (print x (unpack [...]))
  x)

(fn traceView [x ...]
  (print (fennel.view x) (fennel.view (unpack [...])))
  x)

(fn traceInspect [x ...]
  (print (vim.inspect x) (vim.inspect [...]))
  x)

(fn append [t1 t2]
  (let [maxn (table.maxn t1)]
    (each [k v (pairs t2)]
      (if (tonumber k)
          (tset t1 (+ maxn k) v)
          (tset t1 k v)))
    t1))

(fn snoc [xs x]
  (append xs [x]))

(fn replicate [x n]
  (var t [])
  (for [i 1 n]
    (tset t i x))
  t)

(fn evenly-div [x y]
  (let [rem (math.fmod x y)
        num (math.floor (/ x y))]
    (append (replicate (+ 1 num) rem) (replicate num (- y rem)))))

(fn align-str [s width alignment]
  (let [slen (strlen s)]
    (match alignment
      :center (let [[l r] (evenly-div (- width slen) 2)]
                (.. (string.rep " " l) s (string.rep " " r)))
      :right (.. (string.rep " " (- width slen)) s)
      :left (.. s (string.rep " " (- width slen)))
      _ (error (.. "Invalid alignment: " (or alignment :nil))))))

(fn align-strs [s width]
  (let [total-len (accumulate [total-len 0 _ v (ipairs s)]
                    (+ total-len (length v)))
        spaces (icollect [_ v (pairs (evenly-div (- width total-len) (length s)))]
                 v)]
    (table.concat (icollect [i v (ipairs s)]
                    (align-str v (+ (. spaces i) (length v)) :center)))))

(fn align-str-col [s alignment]
  (let [max-str-len (accumulate [len 0 _ v (ipairs s)]
                      (math.max (length v) len))]
    (icollect [_ v (ipairs s)]
      (align-str v max-str-len (or alignment :left)))))

(fn map [f x]
  (collect [k v (pairs x)]
    k
    (f v)))

(fn map2 [f x]
  (map (fn [y]
         (map f y)) x))

(fn for* [x f]
  (map f x))

(fn for2 [x f]
  (map2 f x))

(fn on-init [f xs]
  (let [len (length xs)]
    (append (fcollect [i 1 (- len 1)]
              (f (. xs i))) [(. xs len)])))

(fn num? [n]
  (not= nil (tonumber n)))

(fn splitOn [f x]
  (var t1 [])
  (var t2 [])
  (var switch true)
  (each [_ v (ipairs x)]
    (when (f v)
      (set switch false))
    (if switch
        (table.insert t1 v)
        (table.insert t2 v)))
  (values t1 t2))

(fn chunks [x n]
  (fcollect [i 1 (length x) n]
    (fcollect [j i (- (+ i n) 1)]
      (?. x j))))

(fn transpose [x]
  (var t [])
  (for [i 1 (length x)]
    (for [j 1 (length (. x 1))]
      (if (= nil (?. t j)) (tset t j []))
      (tset t j i (. x i j))))
  t)

(fn head [x]
  (. x 1))

(fn ++ [x y]
  (.. x y))

(fn flip [f x y]
  (f y x))

(fn swap [x f y]
  (f y x))

(fn concat [t1 t2]
  (var maxIdx (table.maxn t1))
  (var t3 [])
  (each [k v (pairs t1)]
    (tset t3 k v))
  (each [k v (pairs t2)]
    (tset t3 (if (num? k) (do
                            (set maxIdx (+ maxIdx 1))
                            maxIdx) k) v))
  t3)

(fn on [t k f]
  (let [x (. t k)]
    (tset t k (f x)))
  t)

(fn but [t k* f]
  (collect [k v (pairs t)]
    k
    (if (= k k*) v (f v))))

(fn basic-hint [x opts]
  (let [colon (or (?. opts :colon) " → ")
        items (icollect [_ v (ipairs x)]
                (if (= nil (?. v 3 :desc))
                    nil
                    (.. "_" (. v 1) "_" colon (. v 3 :desc))))
        colsize (or (?. opts :column-size) 2)
        (columns last) (splitOn (fn [x]
                                  (< (strlen x) colsize))
                                (chunks items colsize))
        border (or (?. opts :border) "         ")
        header (or (?. opts :name) "")
        columns* (->> columns
                      (map align-str-col)
                      (on-init (partial map (partial flip ++ border)))
                      transpose
                      (map table.concat)
                      (map (fn [x]
                             (.. "    " x "    "))))]
    (-> columns*
        (on 1 (partial ++ header))
        (but 1 (partial ++ (string.rep " " (strlen header))))
        (snoc (align-strs (or (?. last 1) []) (strlen (head columns*))))
        (table.concat (or (?. opts :margin) "\n")))))

(fn labeled-hint [x rows opts]
  (let [colon (or (?. opts :colon) " → ")
        rows* (map2 (λ [x]
                      (.. "_" x "_" colon)) rows)
        items (collect [_ v (ipairs x)]
                (if (= nil (?. v 3 :desc))
                    (values nil nil)
                    (values (.. "_" (. v 1) "_" colon) (. v 3 :desc))))]
    (-> rows*
        (for2 (fn [x]
                (.. x (. items x))))
        (for* (partial flip align-strs (or (?. opts :width) 80)))
        (table.concat (or (?. opts :margin) "\n")))))

(fn table-tostring [tbl]
  (local out [])
  (each [k v (pairs tbl)]
    (let [vs (if (= :table (type v)) (table.tostring v) (tostring v))]
      (if (= nil (tonumber k))
          (table.insert out (.. (tostring k) "=" vs))
          (table.insert out (tonumber k) vs))))
  (.. "{" (table.concat out ",") "}"))

(fn assoc [t k v]
  (tset t k v)
  t)

(fn rename-key [from to x]
  (let [val (. x from)]
    (tset x from nil)
    (tset x to val)
    x))

(fn half [x l?]
  (if (or l? true)
      (values (math.floor (/ x 2)) (math.ceil (/ x 2)))
      (values (math.ceil (/ x 2)) (math.floor (/ x 2)))))

(fn replicate [x n]
  (fcollect [_ 1 n]
    x))

(fn /% [x y]
  "returns a pair of `(div x y)` `(mod x y)`"
  (values (math.floor (/ x y)) (math.fmod x y)))

(fn even-div [x y]
  "takes `x y` returns a table of `y` length with digits equal to `x` when added
  >> (even-div 10 4)
      [3 3 2 2]"
  (local (nums rem) (/% x y))
  (concat (replicate (+ 1 nums) rem) (replicate nums (- y rem))))

(fn zip-nil [xs ys f]
  (fcollect [i 1 (math.max (length xs) (length ys))]
    (f (?. xs i) (?. ys i))))

(fn space-strs [strs width]
  (local strings (require :plenary.strings))
  (local spaces-len (even-div (- width
                                 (strings.strdisplaywidth (table.concat strs)))
                              (length strs)))
  (table.concat (zip-nil strs spaces-len
                         (fn [x y]
                           (let [(l r) (half (or y 0))]
                             (.. (string.rep " " l) x (string.rep " " r)))))))

(fn <> [...]
  (var out [])
  (each [_ v (pairs [...])]
    (set out (concat out v)))
  out)

(fn nil? [x]
  (= x nil))

(fn hydra-with-defaults [def-opts]
  (fn [opts]
    (local opts (or opts {}))
    (each [k v (pairs def-opts)]
      (when (nil? (. opts k))
        (tset opts k v)))
    (local hydra (require :hydra))
    (local heads (-> (or (?. opts :heads) (?. def-opts :heads))
                     (concat (or (?. opts :extra-heads) []))))
    (local autohint-opts (or (?. opts :autohint-opts)
                             {:name (?. opts :name)
                              :column-size 2
                              :border "         "}))
    (hydra {:name (?. opts :name)
            :hint (or (?. opts :hint) (basic-hint heads autohint-opts "-"))
            :config (or (?. opts :config)
                        {:invoke_on_body true :hint {:border :rounded}})
            :body (?. opts :body)
            :mode (?. opts :mode)
            : heads})))

{: secrets
 : <>
 : hydra-with-defaults
 : align-str
 : assoc
 : basic-hint
 : concat
 : even-div
 : strlen
 : half
 : labeled-hint
 : num?
 : rename-key
 : space-strs
 : table-tostring
 : trace
 : traceInspect
 : traceView
 : zip-nil
 : swap
 : chunks}
