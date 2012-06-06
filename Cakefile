{spawn} = require('child_process')

run = (cmd, args, cb) ->
   proc = spawn(cmd, args)

   proc.stdout.on 'data', (buf) ->
      process.stdout.write(buf)

   proc.stderr.on 'data', (buf) ->
      process.stderr.write(buf)

   proc.on 'exit', (code) ->
      cb(code)


task 'test', 'run all tests', (options) ->
  # Build up command
  runner = "./node_modules/.bin/mocha"
  args   = ["--compilers", "coffee:iced-coffee-script",
            "--colors",
            "--recursive",
            "test/"]

  # Run tests
  await run runner, args, defer(status)
  if status > 0
     process.exit(status)

