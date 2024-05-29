[
  "in"
  "of"
] @keyword.operator


[
  "const"
  "var"
  "let"
] @type.builtin


(template_substitution
  "${" @punctuation.delimiter
  "}" @punctuation.delimiter) @embedded
