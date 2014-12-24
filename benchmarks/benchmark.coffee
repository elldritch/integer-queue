Queue = require '../dist/queue.min.js'
Deque = require 'double-ended-queue'

# Returns an array test which shifts and repushes random items.
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

# Returns a queue test which shifts and repushes random items.
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

# Returns a deque test which shifts and repushes random items.
make_deque_test = (n) ->
  n = 10 ** n
  deque = new Deque (Math.floor Math.random() * 2 ** 31 for _ in [0...n])

  name: "Deque: #{n} elements"
  maxTime: 1
  fn: ->
    items = [
      deque.shift()
      deque.shift()
      deque.shift()
    ]

    for item in items
      deque.push item

module.exports =
  name: 'Array vs Queue vs Deque'
  tests: (make_array_test n for n in [1..8] by 2).concat (make_queue_test n for n in [1..8] by 2).concat (make_deque_test n for n in [1..8] by 2)
