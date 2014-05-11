#!/usr/bin/env coffee

fs = require 'fs'
readStdinJSON = require('./read-json').readStdinJSON

levelNames = ['order', 'family', 'sub-family', 'genus', 'species']
species = 4
typeSpecies = 5

incorporateProperties = (tree, properties) ->
    recurse = (treeNode, propertyNode, level) ->
        levelName = levelNames[level]
        if treeNode.properties
            if propertyNode.properties
                # For now, don't try to merge properties found in both places.
                throw "Found properties in both tree and properties at level #{levelName}."
        else
            if propertyNode.properties and not propertyNode.properties.INCOMPLETE
                treeNode.properties = propertyNode.properties
        if propertyNode[levelName]
            if not treeNode[levelName]
                throw "Tree has no level #{levelName} but properties does."
            for name of propertyNode[levelName]
                if name not of treeNode[levelName]
                    throw "Could not find name #{name} in tree."
                recurse treeNode[levelName][name], propertyNode[levelName][name], level + 1
    recurse tree, properties, 0


if process.argv.length < 3
    [_..., basename] = process.argv[1].split('/')
    process.stderr.write "Usage: #{basename} properties1.json [properties2.json, ...]\n"
    process.exit 1


readStdinJSON (taxonomy) ->
    for jsonFile in process.argv[2..]
        properties = JSON.parse(fs.readFileSync jsonFile)
        incorporateProperties taxonomy, properties

    process.stdout.write JSON.stringify taxonomy
    process.stdout.write '\n'
