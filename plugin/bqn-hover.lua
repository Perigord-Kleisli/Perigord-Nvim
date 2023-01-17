
local methods = require("null-ls.methods")
local HOVER = methods.internal.HOVER

return require("null-ls.helpers").make_builtin({
  name = "bqn",
  method = HOVER,
  filetypes = {"BQN"},
  generator = function ()
    print ("les go")
    print ("les go")
    print ("les go")
  end,
  meta = {
    url = "https://github.com/mlochbaum/BQN/tree/master/help"
  }
})
