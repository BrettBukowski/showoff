var Stack = require('./stack');

// By maintaining two stacks, one for incoming items, and
// one for outgoing items, we're able to keep pushes O(1)
// and pops O(n).
// Other approaches could involve rebalancing on push / pop,
// which are more complicated and drop into O(n²) territory.


function QueueAsStacks () {
  this.incomingStack = new Stack();
  this.outgoingStack = new Stack();
}

QueueAsStacks.prototype.push = function (item) {
  this.incomingStack.push(item);
};

QueueAsStacks.prototype.pop = function () {
  // Empty out the incoming stack into the outgoing stack.
  // This means that the outgoing will be ordered.
  if (this.outgoingStack.isEmpty()) {
    while (!this.incomingStack.isEmpty()) {
      var item = this.incomingStack.pop();

      // If we're on the last item, don't bother placing it
      // into the stack, just return it.
      if (this.incomingStack.isEmpty()) return item;

      this.outgoingStack.push(item);
    }
  }
  else {
    return this.outgoingStack.pop();
  }
};

module.exports = QueueAsStacks;
