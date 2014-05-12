#!/usr/bin/env coffee

# Propagate envelope information up the tree. If all a node's children's
# envelope types are identical, set the node to have the same type.

readStdinJSON = require('./read-json').readStdinJSON

levelNames = ['order', 'family', 'sub-family', 'genus', 'species']
species = 4

extractEnvelopeType = (tree) ->
    recurse = (node, level) ->
        if level == species
            return

        levelName = levelNames[level]
        if node[levelName]
            # Call ourselves on our children
            for name of node[levelName]
                recurse node[levelName][name], level + 1

            # Look for a common envelope type in all our children.
            first = true
            for name of node[levelName]
                if node[levelName][name].properties?.envelope?
                    thisEnvelope = node[levelName][name].properties.envelope
                    if first
                        first = false
                        common = thisEnvelope
                    else
                        if common != thisEnvelope
                            if common == true and thisEnvelope == false or common == false and thisEnvelope == true
                                common = 'both'
                            else if common == 'both' and (thisEnvelope == true or thisEnvelope == false)
                                common == 'both' # Do nothing.
                            else
                                # Not all children have the same envelope type.
                                return
                else
                    # A child with no envelope setting doesn't result in
                    # the parent getting a setting.
                    return

            if first
                # No children had an envelope.
                return

            node.properties ?= {}

            # If the node already has an envelope set, make sure it's the
            # same as the common child value.
            if 'envelope' of node.properties
                if node.properties.envelope != common
                    process.stderr.write ("Tree node has envelope type #{node.properties.envelope} " +
                                          "but all its children have envelope type #{common}.\n")
                    process.exit 1
                else
                    process.stderr.write ("Tree node has unecessary envelope type #{common}. " +
                                          "All its children already have the same envelope type.\n")
            else
                node.properties.envelope = common

    recurse tree, 0
    tree

readStdinJSON (json) ->
    process.stdout.write JSON.stringify(extractEnvelopeType json)
    process.stdout.write '\n'
