function Stack () {
  this.list = [];
}

Stack.prototype.push = function (item) {
  this.list.push(item);
};

// Assumes the caller first checks #isEmpty
// before doing a pop :)
Stack.prototype.pop = function () {
  return this.list.splice(-1, 1)[0];
};

Stack.prototype.isEmpty = function () {
  return this.list.length == 0;
};

module.exports = Stack;
