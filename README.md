# Queue
Hello, all! My name is Lehao Zhang, and this is my submission to the 2014 KPCB Engineering Fellows application challenge problem.

## Building
Install Node.js (`sudo apt-get install nodejs` or equivalent), then `cd` into this directory and `npm -g install grunt-cli mocha; npm install`. Run `grunt` to compile into JavaScript, or `npm -g install coffee-script` if you want to try out CoffeeScript (it's awesome, trust me). Compiled JavaScript files will be in `dist/queue.min.js`, the CoffeeScript source is in `src/queue.coffee`.

## Usage
### `new Queue(size)`
Create a new `Queue` that holds `size` elements.

### `queue.enqueue(item)`
Attempt to enqueue `item`. If the queue is full, throw a `QueueException`. If `item` cannot be represented as a signed 32-bit integer, the behaviour of the queue following this action is undefined.

### `queue.dequeue()`
Attempt to dequeue the next item. If the queue is empty, throw a `QueueException`.

## Testing, etc.
Testing is done with `mocha`: use `npm test` to run the test suite. Benchmarking is a Grunt task: run `grunt profile` to see how this queue performs against a naive solution using native arrays. Notice that the naive solution slows dramatically past 100k elements or so (because of an [optimisation trick](https://code.google.com/p/v8/issues/detail?id=3059) that Node.js uses for small arrays).

## Implementation details
Using an array is a bad idea, because `shift` re-indexes the array every time and thus a `push`/`shift` (or even worse, an `unshift`/`pop`) queue runs in linear time with respect to its length. Implementing this as two stacks is great, but is also twice as much memory as we actually need. Instead, this implementation uses a fixed-size circular buffer.

The buffer is actually a [typed `Int32Array`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Typed_arrays) for storing two's complement signed 32-bit integers. If more or less range is needed, swap out the `DataView` for something more appropriate (e.g. `Uint32Array` or `Int16Array`) and adjust `Queue.BYTES_PER_ELEMENT` accordingly.

## Notes
Yes, I am aware the problem said "no external libraries should be imported or used". I chose to interpret that as "don't use external libraries while building your queue" rather than "don't use external libraries at all" for two reasons:

1. In production, libraries are used everywhere all the time. It's an unrealistic constraint to expect a candidate to never use libraries. I see the value of this constraint to be for testing whether candidates can develop smart data structures on their own.
2. I'm not building a testing framework from scratch. I have a life and stuff to do, and I think it's more useful that I show I know how to use industry-standard tools rather than hack up some homebrewed framework out of shell scripts just for this one case.
