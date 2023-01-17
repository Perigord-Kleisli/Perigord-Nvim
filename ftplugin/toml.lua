if (vim.fn.expand("%:t") == "Cargo.toml") then
  local crates = require("crates")
  local hydra = require("Mapping.Lang")
  vim.keymap.set("n", "K", crates.show_crate_popup, {noremap = true, silent = true})
  return hydra({heads = {{"v", crates.show_versions_popup, {desc = "Crate Versions"}}, {"u", crates.upgrade_crate, {desc = "Upgrade Crate"}}, {"U", crates.upgrade_all_crates, {desc = "Upgrade All Crates"}}, {"K", crates.show_crate_popup, {desc = "Crate Details"}}, {"k", vim.diagnostic.goto_prev, {desc = "Previous Diagnostic"}}, {"j", vim.diagnostic.goto_next, {desc = "Next Diagnostic"}}, {"t", crates.toggle, {desc = "Toggle Versions", exit = true}}}})
else
  return nil
end
