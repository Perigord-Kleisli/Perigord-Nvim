(local dracula (require :dracula))
(dracula.setup {:colors {:bg "#09090A"
                         :menu "#080a0c"
                         :visual "#272568"
                         :selection "#232057"}
                :italic_comment true
                :transparent-background true})

(vim.api.nvim_command "colorscheme dracula")

(set vim.g.termguicolors true)
(set vim.opt.scrolloff 8)
(set vim.o.wrap false)
(set vim.o.splitbelow true)
(set vim.o.mouse :a)

(set vim.o.number true)
(set vim.o.relativenumber true)
(vim.api.nvim_create_autocmd [:InsertEnter]
                             {:pattern "*" :command "set norelativenumber"})

(vim.api.nvim_create_autocmd [:InsertLeave]
                             {:pattern "*" :command "set relativenumber"})

(vim.api.nvim_create_autocmd [:TextYankPost]
                             {:pattern "*"
                              :callback (fn []
                                          (vim.highlight.on_yank {:higroup :visual
                                                                  :timeout 180}))})

(local dressing (require :dressing))
(dressing.setup)

(fn _G.qftf [info]
  (var items nil)
  (local ret {})
  (if (= info.quickfix 1) (set items
                               (. (vim.fn.getqflist {:id info.id :items 0})
                                  :items))
      (set items (. (vim.fn.getloclist info.winid {:id info.id :items 0})
                    :items)))
  (local limit 31)
  (local (fname-fmt1 fname-fmt2)
         (values (.. "%-" limit :s) (.. "…%." (- limit 1) :s)))
  (local valid-fmt "%s │%5d:%-3d│%s %s")
  (for [i info.start_idx info.end_idx]
    (local e (. items i))
    (var fname "")
    (var str nil)
    (if (= e.valid 1)
        (do
          (when (> e.bufnr 0)
            (set fname (vim.fn.bufname e.bufnr))
            (if (= fname "") (set fname "[No Name]")
                (set fname (fname:gsub (.. "^" vim.env.HOME) "~")))
            (if (<= (length fname) limit) (set fname (fname-fmt1:format fname))
                (set fname (fname-fmt2:format (fname:sub (- 1 limit))))))
          (local lnum (or (and (> e.lnum 99999) (- 1)) e.lnum))
          (local col (or (and (> e.col 999) (- 1)) e.col))
          (local qtype
                 (or (and (= e.type "") "")
                     (.. " " (: (e.type:sub 1 1) :upper))))
          (set str (valid-fmt:format fname lnum col qtype e.text)))
        (set str e.text))
    (table.insert ret str))
  ret)

(set vim.o.qftf "{info -> v:lua._G.qftf(info)}")

(local bqf (require :bqf))
(bqf.setup)

(local presence (require :presence))
(presence:setup {:neovim_image_text :Neovim})
