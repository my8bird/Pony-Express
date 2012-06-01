{exec} = require 'child_process'

task 'test', 'run all tests', (options) ->
  # Build up command
  runner       = '.node_modules/.bin/mocha'
  coffee_flags = '--compilers coffee:iced-coffee-script'
  extra_flags  = '--recursive'

  # Create List of files to test
  tests        = 'test/'

  # Run tests
  exec '{runner} {coffe_flags} {extra_flags} {tests}'


