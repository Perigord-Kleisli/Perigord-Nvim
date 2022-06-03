(module Lang.Treesitter 
  {autoload {treesitter nvim-treesitter.configs}
   autoload {treesitter-context treesitter-context}})

(treesitter.setup 
  { :ensure_installed ["toml" "bash" "c" "cpp" "fennel" "haskell" "python" "rust" "javascript" "lua" "html" "scss" "markdown" "nix" "html" "regex"] 
    :indent {:enable true}
    :autopairs {:enable true}
    :matchup {:enable true}
    :rainbow 
     {:enable true}
    :playground 
     {:enable true}
    :refactor 
     {:highlight_current_scope
      {:enable false}}

    :textobjects
     {:select
       {:enable true
        :lookahead true
        :keymaps 
         {:af "@function.outer"
          :if "@function.inner"
          :ac "@class.outer"
          :ic "@class.inner"}}}})

(treesitter-context.setup
  {:enable true})
