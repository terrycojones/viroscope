#!/usr/bin/env coffee

# Canonicalize each node.

readStdinJSON = require('./read-json').readStdinJSON

levelNames = ['order', 'family', 'sub-family', 'genus', 'species']
species = 4

canonicalize = (tree) ->
    recurse = (node, level) ->

        levelName = levelNames[level]
        if node[levelName]
            # Call ourselves on our children
            for name of node[levelName]
                recurse node[levelName][name], level + 1

        if node.properties?.host?
            node.properties.host.sort()

    recurse tree, 0
    tree

readStdinJSON (json) ->
    process.stdout.write JSON.stringify(canonicalize json)
    process.stdout.write '\n'
