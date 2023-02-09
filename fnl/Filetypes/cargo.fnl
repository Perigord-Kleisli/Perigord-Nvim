(local crates (require :crates))
(local {:lang-map wk} (require :Mapping.Lang))
(vim.keymap.set :n :K crates.show_crate_popup {:noremap true :silent true})
(wk {:name :Cargo
     :pattern :Cargo.toml
     :mode :n
     :heads [[:v
              crates.show_versions_popup
              {:desc "Crate Versions"}]
             [:u crates.upgrade_crate {:desc "Upgrade Crate"}]
             [:U
              crates.upgrade_all_crates
              {:desc "Upgrade All Crates"}]
             [:j
              vim.diagnostic.goto_next
              {:exit false :desc "Next Diagnostic"}]
             [:k
              vim.diagnostic.goto_prev
              {:exit false :desc "Previous Diagnostic"}]
             [:K crates.show_crate_popup {:desc "Crate Details"}]
             [:t crates.toggle {:desc "Toggle Versions"}]]})

(vim.keymap.set :n :K crates.show_crate_popup
                {:noremap true :silent true :desc "Crate Details"})
