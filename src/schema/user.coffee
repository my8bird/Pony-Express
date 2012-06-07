mongoose = require('mongoose')

User = new mongoose.Schema(
   name:   String
   joined: Date
   contact_methods: []
)

# Add model so that it can be accessed by others.
mongoose.model('User', User)

# Export it in case we want to just grab it.
exports.User = User
