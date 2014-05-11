# Notes on properties

## Canonicalization

Propery canonicalization is done by `003-canonicalize.coffee`.

* The array of `host` values will be sorted.

## Extraction of values

* `virionSize` is computed automatically by `005-virion-size.coffee` from
  the smallest and largest numbers found in the `virionDescription` for the
  node.  No `virionSize` is permitted to appear on a node (this can be
  changed if need be).

## Upward propagation

* `virionSize` is propagated up the tree, by
  `010-virion-size-propagate-up.coffee` based on the min/max virion sizes
  of a node's children.

* `genome.type` is propagated up the tree by
  `010-genome-type-propagate-up.coffee`. If a node's children all have the
  same type, the node's `genome.type` is set to that common value.

* `envelope` is propagated up the tree by
  `010-envelope-propagate-up.coffee`. If a node's children all have the
  same type, the node's `envelope` is set to that common value.

## Downward propagation

Properties are propagated downwards to child nodes on the client.
