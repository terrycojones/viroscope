'use strict'

csv = require 'csv'
fs = require 'fs'

order = 0
family = 1
subfamily = 2
genus = 3
species = 4
typeSpecies = 5

app =
    add: (a, b) ->
        a + b

    convert: (taxonomyCSV, cb) ->
        tree = {children: {}}

        add = (root, row, offset) ->
            if offset == typeSpecies
                return
            name = row[offset]
            if not name
                name = 'Unassigned'
            if name not of root.children
                root.children[name] = {}
                if offset == species
                    root.children[name].typeSpecies = +row[typeSpecies]
                else
                    root.children[name].children = {}
            add root.children[name], row, offset + 1

        csv()
            .from.stream(fs.createReadStream(taxonomyCSV))
            .on('record', (row, index) ->
                # Swap typeSpecies and species (cols 4 and 5)
                tmp = row[4]
                row[4] = row[5]
                row[5] = tmp
                add tree, row, 0
            )
            .on('end', (count) =>
                cb false, tree
            )

exports = module.exports = app
