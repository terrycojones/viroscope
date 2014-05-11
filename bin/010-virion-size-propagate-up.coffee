#!/usr/bin/env coffee

# Propagate virion size information up the tree. Look at the max/min virion
# size in all a node's children and set the node's value to the min/max
# across all children.

readStdinJSON = require('./read-json').readStdinJSON

levelNames = ['order', 'family', 'sub-family', 'genus', 'species']
species = 4

propagateVirionSize = (tree) ->
    recurse = (node, level) ->
        if level == species
            return

        levelName = levelNames[level]
        if node[levelName]
            # Call ourselves on our children
            for name of node[levelName]
                recurse node[levelName][name], level + 1

            # Look for virion size information in all our children.
            sizes = []
            for name of node[levelName]
                if node[levelName][name].properties?.virionSize
                    sizes.push(node[levelName][name].properties.virionSize[0])
                    sizes.push(node[levelName][name].properties.virionSize[1])

            node.properties ?= {}

            # If no virion sizes were found in our children, we're done.
            if sizes.length == 0
                return

            [ min, max ] = [ Math.min(sizes...), Math.max(sizes...) ]

            # If the node already has a virion size set, make sure it's the
            # same as the children min/max value.
            if node.properties.virionSize
                if node.properties.virionSize[0] != min or node.properties.virionSize[1] != max
                    process.stderr.write ("Tree node has virion size #{node.properties.virionSize} " +
                                          "which conflicts with the agregate information in its children " +
                                          " which have a max of #{max} and a min of #{min}.")
                    process.exit 1
                else
                    process.stderr.write ("Tree node has unecessary virion size information #{min}-#{max}. " +
                                          "This value can be inferred from its children.\n")
            else
                node.properties.virionSize = [min, max]

    recurse tree, 0
    tree

readStdinJSON (json) ->
    process.stdout.write JSON.stringify(propagateVirionSize json)
    process.stdout.write '\n'
