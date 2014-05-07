'use strict';

fs = require 'fs'
data = require './data'

exports.taxonomy = (req, res) ->
    data.convert 'data/taxonomy.csv', (err, result) ->
        if err
            throw err
        res.json result

exports.properties = (req, res) ->
    fs.readFile 'data/properties.json', (err, result) ->
        if err
            throw err
        res.type 'application/json'
        res.send result
