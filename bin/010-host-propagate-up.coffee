#!/usr/bin/env coffee

# Propagate host range information up the tree. Look at the hosts in all a
# node's children and set the node's value to the union of hosts across all
# children.

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

            # Look for host information in all our children.
            hosts = {}
            count = 0
            for name of node[levelName]
                if node[levelName][name].properties?.host
                    for host in node[levelName][name].properties.host
                        if host not in ["Al", "Ar", "B", "F", "I", "P", "Pr", "V"]
                            process.stderr.write "Unknown host abbreviation #{host}.\n"
                            process.exit 1
                        count += 1
                        hosts[host] = true

            node.properties ?= {}

            # If no hosts were found in our children, we're done.
            if count == 0
                return

            # Convert to a sorted list.
            hostList = []
            for host of hosts
                hostList.push host

            hostList.sort()

            # If the node already has host list, make sure it's the
            # same as the union of its children.
            if node.properties.host
                if node.properties.host.join() != hostList.join()
                    process.stderr.write ("Tree node has host #{node.properties.host} " +
                                          "which conflicts with its children's hosts, " +
                                          " which have a union of #{hostList}.")
                    process.exit 1
                else
                    process.stderr.write ("Tree node has unecessary host information #{hostList}. " +
                                          "This value can be inferred from its children.\n")
            else
                node.properties.host = hostList

    recurse tree, 0
    tree

readStdinJSON (json) ->
    process.stdout.write JSON.stringify(propagateVirionSize json)
    process.stdout.write '\n'
