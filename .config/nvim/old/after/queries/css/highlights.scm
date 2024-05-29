[
 "@media"
 "@import"
 "@charset"
 "@namespace"
 "@supports"
 "@keyframes"
 (at_keyword)
 (to)
 (from)
 ] @include

[ (important) ] @constant


[
 (tag_name)
 (nesting_selector)
 (universal_selector)
 ] @keyword


[
 (namespace_name)
 ; (property_name)
 (feature_name)
 (attribute_name)
 ] @variable.builtin

[ (class_name) ] @string.escape
[ (id_name) ] @string.escape

(pseudo_element_selector (tag_name) @keyword)
(pseudo_class_selector (class_name) @keyword)

((property_name) @keyword
                 (#match? @keyword "^--"))
((plain_value) @keyword
               (#match? @keyword "^--"))

[ (unit) ] @number
