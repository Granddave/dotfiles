;; extends

(block_mapping_pair
  key: (flow_node) @_k
  (#any-of? @_k "bash" "script")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "bash")
    (#offset! @injection.content 0 1 0 0)))
