(when (= (vim.fn.expand "%:t") :Cargo.toml)
  (local crates (require :crates))
  (local {:lang-map wk} (require :Mapping.Lang))
  (vim.keymap.set :n :K crates.show_crate_popup {:noremap true :silent true})
  (wk {:v [crates.show_versions_popup "Crate Versions"]
       :u [crates.upgrade_crate "Upgrade Crate"]
       :U [crates.upgrade_all_crates "Upgrade All Crates"]
       :K [crates.show_crate_popup "Crate Details"]
       :k [vim.diagnostic.goto_prev "Previous Diagnostic"]
       :e :which_key_ignore
       :r :which_key_ignore
       :i :which_key_ignore
       :j [vim.diagnostic.goto_next "Next Diagnostic"]
       :t [crates.toggle "Toggle Versions"]}))
