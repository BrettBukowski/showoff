var Queue = require('./queue'),
    assert = require('assert');

var queue = new Queue();
queue.push("A");
assert.equal("A", queue.pop());
queue.push("B");
queue.push("C");
queue.push("D");
assert.equal("B", queue.pop());
assert.equal("C", queue.pop());
assert.equal("D", queue.pop());
assert.equal(undefined, queue.pop());

console.log("Tests pass :)");
