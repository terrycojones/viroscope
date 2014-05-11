#!/usr/bin/env coffee

# Examine the virionDescription property of all nodes. If it contains
# any numbers, pull out the smallest and largest and put them into a
# virion property.

readStdinJSON = require('./read-json').readStdinJSON

levelNames = ['order', 'family', 'sub-family', 'genus', 'species']
species = 4
numberRegex = /([0-9]+)/g

extractVirionSize = (tree) ->
    recurse = (node, level) ->
        if node.properties?.virionSize
            throw "Node found that already has a vironSize property"
        virionDescription = node.properties?.virionDescription
        if virionDescription
            sizes = virionDescription.match /\d+/g
            if sizes
                sizes = (+size for size in sizes)
                node.properties.virionSize = [Math.min(sizes...), Math.max(sizes...)]
        # Call ourselves on our children, if any.
        if level != species
            levelName = levelNames[level]
            if node[levelName]
                for name of node[levelName]
                    recurse node[levelName][name], level + 1
        node
    recurse tree, 0

readStdinJSON (json) ->
    process.stdout.write JSON.stringify(extractVirionSize json)
    process.stdout.write '\n'
