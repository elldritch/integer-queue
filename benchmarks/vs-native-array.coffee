Queue = require '../dist/queue.min.js'

make_array_test = (n) ->
  n = 10 ** n
  array = (Math.floor Math.random() * 2 ** 31 for _ in [0...n])

  name: "Array: #{n} elements"
  maxTime: 1
  fn: ->
    items = [
      array.shift()
      array.shift()
      array.shift()
    ]

    for item in items
      array.push item

make_queue_test = (n) ->
  n = 10 ** n
  q = new Queue n
  q.enqueue Math.floor Math.random() * 2 ** 31 for _ in [0...n]

  name: "Queue: #{n} elements"
  maxTime: 1
  fn: ->
    items = [
      q.dequeue()
      q.dequeue()
      q.dequeue()
    ]

    for item in items
      q.enqueue item

module.exports =
  name: 'Queue vs Array'
  tests: (make_array_test n for n in [1..8] by 2).concat (make_queue_test n for n in [1..8] by 2)
