# Queue
This is a fixed-size queue that is uses [typed arrays](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Typed_arrays) to beat the native implementation in terms of speed.

## Installation
`npm install integer-queue`, then `require('integer-queue')`.

## Usage
### `new Queue(size[, type])`
Create a new `Queue` that holds `size` elements of type `type` (see [typed array views](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Typed_arrays#Typed_array_views)). This defaults to `Int32Array`.

### `queue.enqueue(item)`
Attempt to enqueue `item`. If the queue is full, throw a `QueueException`. If `item` cannot be represented as an instance of the Queue's `type`, behaviour following this action is undefined.

### `queue.dequeue()`
Attempt to dequeue the next item. If the queue is empty, throw a `QueueException`.

## Testing, etc.
Run `npm test` to run the test suite. Run `grunt profile` to see how this queue performs against a naive solution using native arrays. Notice that the naive solution slows dramatically past 100k elements or so (because of an [optimisation trick](https://code.google.com/p/v8/issues/detail?id=3059) that Node.js uses for small arrays).

## Implementation details
Using an array is a bad idea, because `shift` re-indexes the array every time and thus a `push`/`shift` (or even worse, an `unshift`/`pop`) queue runs in linear time with respect to its length.
