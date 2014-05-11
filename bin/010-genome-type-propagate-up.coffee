#!/usr/bin/env coffee

# Propagate genome type information up the tree. If all a node's children's
# genome types are identical, set the node to have the same type.

readStdinJSON = require('./read-json').readStdinJSON

levelNames = ['order', 'family', 'sub-family', 'genus', 'species']
species = 4

extractGenomeType = (tree) ->
    recurse = (node, level) ->
        if level == species
            return

        levelName = levelNames[level]
        if node[levelName]
            # Call ourselves on our children
            for name of node[levelName]
                recurse node[levelName][name], level + 1

            for attr in ['type', 'configurationDescription', 'positive', 'negative', 'ambisense', 'RT']

                # Look for a common genome value in all our children.
                first = true
                same = true
                for name of node[levelName]
                    if node[levelName][name].properties?.genome
                        if first
                            first = false
                            common = node[levelName][name].properties.genome[attr]
                        else
                            if common != node[levelName][name].properties.genome[attr]
                                # Not all children have the same value
                                same = false
                                break
                    else
                        # If a child doesn't have any genome properties,
                        # the parent can't get a common setting.
                        same = false
                        break

                if same and not first
                    node.properties ?= {}
                    node.properties.genome ?= {}
                    node.properties.genome[attr] = common

            # Compute min/max genome length amongst our children
            first = true
            for name of node[levelName]
                if node[levelName][name].properties?.genome?.length
                    thisMin = node[levelName][name].properties.genome.length[0]
                    thisMax = node[levelName][name].properties.genome.length[1]
                    if first
                        first = false
                        min = thisMin
                        max = thisMax
                    else
                        if thisMin < min
                            min = thisMin
                        if thisMax > max
                            max = thisMax

            # thisMin might be undefined if we have length = [] in some nodes.
            # TODO: remove the undefined check once we have all the data in.
            if not first and thisMin isnt undefined
                node.properties ?= {}
                node.properties.genome ?= {}
                node.properties.genome.length = [min, max]

    recurse tree, 0
    tree

readStdinJSON (json) ->
    process.stdout.write JSON.stringify(extractGenomeType json)
    process.stdout.write '\n'
