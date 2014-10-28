chai = require 'chai'
expect = chai.expect

Queue = require '../index'

describe 'Queue', ->
  it 'queues items correctly', ->
    q = new Queue 10
    q.enqueue item for item in [0...10]

    for item in [0...10]
      result = q.dequeue()
      expect(result).to.equal item

  it 'handles full edge cases', ->
    q = new Queue 10
    q.enqueue item for item in [0...10]
    expect(-> q.enqueue 10).to.throw Error

  it 'handles empty edge cases', ->
    q = new Queue 10
    expect(-> q.dequeue()).to.throw Error

  it 'handles random inputs robustly', ->
    for power in [0..16]
      length = 2 ** power

      q = new Queue length
      array = []

      for _ in [0...length]
        next = Math.floor Math.random() * (2 ** 31)
        array.unshift next
        q.enqueue next

      for _ in [0...length]
        expect(q.dequeue()).to.equal array.pop()
