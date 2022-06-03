(module UI.Bufferline
  {autoload {bufferline bufferline}})

(bufferline.setup 
  {:separator_style :slant
   :diagnostics :nvim_lsp})

  
