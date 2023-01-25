(local range-highlight (require :range-highlight))

(range-highlight.setup)

(local colorizer (require :colorizer))
(colorizer.setup {:user_default_options {:mode :virtualtext}})

((. (require :colortils) :setup) {:mappings {:replace_default_format :<cr>}})
