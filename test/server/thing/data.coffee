'use strict'

should = require 'should'
data = require '../../../lib/controllers/data'

describe('convert', ->

  it('should know how to add', ->
    data.add(3, 4).should.equal(7)
  )

)
