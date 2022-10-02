local _2afile_2a = "fnl/Lang/Cmp-Nvim.fnl"
local _2amodule_name_2a = "Lang.Cmp-Nvim"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local autoload = (require("aniseed.autoload")).autoload
local luasnip, comparator, dictionary, cmp = autoload("luasnip"), autoload("cmp-under-comparator"), autoload("cmp_dictionary"), autoload("cmp")
do end (_2amodule_locals_2a)["luasnip"] = luasnip
_2amodule_locals_2a["comparator"] = comparator
_2amodule_locals_2a["dictionary"] = dictionary
_2amodule_locals_2a["cmp"] = cmp
local kind_icons = {Text = "\239\157\190", Method = "m", Function = "\239\158\148", Constructor = "\239\144\165", Field = "\238\156\150", Variable = "\239\154\166", Class = "\239\160\150", Interface = "\239\131\168", Module = "\239\146\135", Property = "\239\130\173", Unit = "\238\136\159", Value = "\239\162\159", Enum = "\239\133\157", Keyword = "\239\160\138", Snippet = "\239\131\132", Color = "\239\163\151", File = "\239\156\152", Reference = "\239\146\129", Folder = "\239\157\138", EnumMember = "\239\133\157", Constant = "\239\155\188", Struct = "\239\134\179", Event = "\239\131\167", Operator = "\239\154\148", TypeParameter = "\239\158\131"}
_2amodule_locals_2a["kind-icons"] = kind_icons
local kind_menu = {nvim_lsp = "[LSP]", luasnip = "[Snippet]", calc = "[Calc]", greek = "[Greek]", latex_symbols = "[Symbol]", treesitter = "[TS]", dictionary = "[Dict]", buffer = "[File]", path = "[Path]"}
_2amodule_locals_2a["kind-menu"] = kind_menu
local function _1_(args)
  return luasnip.lsp_expand(args.body)
end
local function _2_(entry, vim_item)
  vim_item.kind = kind_icons[vim_item.kind]
  vim_item.menu = kind_menu[entry.source.name]
  return vim_item
end
cmp.setup({snippet = {expand = _1_}, sources = cmp.config.sources({{name = "nvim_lsp"}, {name = "nvim_lua"}, {name = "luasnip"}, {name = "path"}, {name = "calc"}, {name = "latex_symbols"}, {name = "nvim_lsp_signature_help"}, {name = "treesitter", keyword_length = 2}, {name = "buffer", keyword_length = 2}, {name = "dictionary", keyword_length = 3}}), mapping = {["<C-k>"] = cmp.mapping.select_prev_item(), ["<C-j>"] = cmp.mapping.select_next_item(), ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), {"i", "c"}), ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), {"i", "c"}), ["<CR>"] = cmp.mapping.confirm({select = true})}, window = {documentation = cmp.config.window.bordered({winhighlight = "FloatBorder:VisualNOS"})}, sorting = {comparators = {cmp.config.compare.offset, cmp.config.compare.exact, cmp.config.compare.score, comparator.under, cmp.config.compare.kind, cmp.config.compare.sort_text, cmp.config.compare.length, cmp.config.compare.order}}, formatting = {fields = {"kind", "abbr", "menu"}, format = _2_}, experimental = {ghost_text = true}})
dictionary.setup({dic = {["*"] = {(os.getenv("XDG_DATA_HOME") .. "/words")}}})
return _2amodule_2a