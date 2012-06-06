mongoose = require('mongoose')

User = new mongoose.Schema(
   name:   String
   joined: Date
   contact_methods: []
)

mongoose.model('User', User)
