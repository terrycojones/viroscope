'use strict';

fs = require 'fs'

exports.taxonomy = (req, res) ->
    fs.readFile 'data/taxonomy.json', (err, result) ->
        if err
            throw err
        res.type 'application/json'
        res.send result
