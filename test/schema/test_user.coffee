mongoose = require('mongoose')
should   = require('should')

# Adds Model to mongoose
require('../../src/schema/user')

mongoose.connect('mongodb://localhost:27017/pony-test')

User = mongoose.model('User')

describe 'User Data Model', () ->

   beforeEach (done) ->
      # XXX clear all tables from database
      done()

   it 'should allow saving to the database', (done) ->
      # Create an User
      user = new User({name: 'bobo'})
      # Save the user to the database
      await user.save(defer err)
      # Ensure no errors happened with saving
      should.not.exist(err)

      # Grab the user from the database
      await User.findById(user._id, defer(err, user_doc))
      # Ensure no errors happened with saving
      should.not.exist(err)
      should.exist(user_doc)
      # Test that the user was saved with the correct values
      user_doc.name.should.equal('bobo')

      done()
