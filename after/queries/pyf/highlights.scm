(string_content) @string
(interpolation
  ["{" "}"] @punctuation.special)

(interpolation
  (format_specifier
    ":" @punctuation.delimeter))
    
(interpolation
  (format_specifier
    "#" @number))

(padding
  (padding_character) @string)
(padding
  ["<" ">" "^" "="] @operator)
(representation) @number

(value) @number
(rounding) @number
(escaped_string_content) @punctuation.special

(grouping) @string
