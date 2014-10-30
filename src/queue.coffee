class QueueException extends Error
  @name: 'QueueException'

  constructor: (@message) ->
    @stack = (new Error @message).stack


class Queue
  @BYTES_PER_ELEMENT: 4

  constructor: (@length) ->
    buffer = new ArrayBuffer Queue.BYTES_PER_ELEMENT * @length
    @q = new Int32Array buffer

    @head = 0
    @tail = 0

  enqueue: (item) ->
    if @tail % @length is @head % @length and @tail isnt 0
      throw new QueueException 'Attempted to add to full queue.'

    @q[@tail % @length] = item
    @tail++
    @

  dequeue: ->
    if @tail is @head
      throw new QueueException 'Attempted to dequeue an empty queue.'

    @head++
    @q[(@head - 1) % @length]

module.exports = Queue
