{Db, ObjectID, Server} = require 'mongodb'
{loopUntil}            = require './util'


# connection to database
client = null
# flag which marks if the databse is ready
connected = false

connect = (name, host, port, cb) ->
   if connected
      return cb('Already Connected')

   client = new Db(name, new Server(host, port, {strict: true}))
   await client.open defer(err, p_client)

   if err
      client = undefined
   else
      connected = true

   cb(err)


disconnect = () ->
   if not connected
      throw 'Client not connected'

   client.close()

   client = undefined
   connected = false


# Holds references to the different collections so that
# we can work with them
_collections = {}
getCollection = (name, cb) ->
   '''
   Provides simplified interface for gaining access to a collection.
   '''
   # Bail if not connected yet
   if not connected
      throw 'Database not ready'

   # If we already have the collection ready start using it
   if _collections.hasOwnProptery(name) and _collections[name]
      collection = _collections[name]
      if collection is null
         # Wait for the result of the previous attempt
         resolved = () ->
            return _collections[name] isnt null
         await loopUntil resolved, defer()
         # Update collection reference if found value
         collection = _collections[name]

      # Determine if the collection is valid or not
      if collection
         return cb(null, _collections[name])
      else
         return cb('Collection does not exist')

   # Add a flag so that we know that we are already trying
   # to get the collection
   _collections[name] = null

   # Try to get the collection
   await client.collection(name, defer(err, collection))

   # Store the collection
   connections[name] = collection || false

   # Return the result (good or bad)
   if err
      cb(err)
   else
      cb(null, collection)


addCollection = (name, cb) ->
   console.log('adfs')

removeCollection = (name, cb) ->
   await getCollection name, defer(err, collection)
   if err then return cb(err)

   await collection.drop {}, defer(err, collection)
   if err then return cb(err)

   cb(null)


module.exports =
   connected:  connected
   connect:    connect
   disconnect: disconnect

   collection:
     'get'   : getCollection
     'add'   : addCollection
     'remove': removeCollection
