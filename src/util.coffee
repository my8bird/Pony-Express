loopUntil = (predicate, cb) ->
   interval = setInterval ->
      if predicate()
         clearInterval(interval)
         cb()
   , 100

