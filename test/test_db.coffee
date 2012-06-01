db     = require('../src/db')
should = require('should')

config =
  good:
    host: 'localhost'
    port: 27017
  bad:
    host: 'localhost'
    port: 3000


describe 'Database Connection Handling', () ->
   it 'should be able to connect to a database', (done) ->
      await db.connect config.good.host, config.good.port, defer(err)
      should.not.exist(err)
      db.disconnect()
      done()

   it 'should fail gracefully if we can not connect', (done) ->
      await db.connect config.bad.host, config.bad.port, defer(err)
      err.should.be.a('object').and.have.property('message')
      err.message.should.equal('failed to connect to [localhost:3000]')
      done()

describe 'Database Management', () ->
   beforeEach (done) ->
      await db.connect config.good.host, config.good.port, defer(err)
      should.not.exist(err)
      done()

   afterEach () ->
      db.disconnect()

   it 'should allow adding collections', (done) ->
      done()
