#!/usr/bin/env coffee

csv = require 'csv'

levelNames = ['order', 'family', 'sub-family', 'genus', 'species']
species = 4
typeSpecies = 5

convert = (callback) ->
    tree = {}

    add = (root, row, level) ->
        levelName = levelNames[level]
        if levelName not of root
            root[levelName] = {}
        name = row[level]
        if not name
            name = 'Unassigned'
        if name not of root[levelName]
            root[levelName][name] = {}
            if level == species
                root[levelName][name].properties =
                    typeSpecies: +row[typeSpecies]
        unless level == species
            add root[levelName][name], row, level + 1

    csv()
        .from.stream(process.stdin)
        .on('record', (row, index) ->
            # Swap typeSpecies and species (cols 4 and 5)
            tmp = row[4]
            row[4] = row[5]
            row[5] = tmp
            add tree, row, 0
        )
        .on('end', ->
            callback tree
        )

convert (taxonomy) ->
    process.stdout.write JSON.stringify taxonomy
    process.stdout.write '\n'
