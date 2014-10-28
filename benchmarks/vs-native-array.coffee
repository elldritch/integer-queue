Queue = require '../dist/queue.min.js'

seq = (Math.floor Math.random() * (2 ** 31) for _ in [0...(2 ** 16)])

make_array_test = (n, seq) ->
  name: "2^#{n} elements, native array"
  maxTime: 1
  fn: ->
    array = []

    for i in [0...n]
      next = seq[i]
      array.unshift next

    for i in [0...n]
      array.pop()

make_queue_test = (n, seq) ->
  name: "2^#{n} elements, queue"
  maxTime: 1
  fn: ->
    q = new Queue n

    for i in [0...n]
      next = seq[i]
      q.enqueue next

    for i in [0...n]
      q.dequeue()

module.exports =
  name: 'queue v. native array implementation'
  tests: (make_queue_test n, seq for n in [0..32] by 3).concat (make_array_test n, seq for n in [0..32] by 3)
