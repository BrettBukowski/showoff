// Mth-to-last element in a linked list.
// <https://www.hackerrank.com/contests/programming-interview-questions/challenges/m-th-to-last-element>
//
package main

import (
	"fmt"
	"os"
	"strconv"
)

// A doubly-linked list allows adds to be O(1)
// and seeks to the Mth element O(M).
// A single linked list forces adds to be O(n)
// and seeks to the Mth element O(n + M).
type Node struct {
	value int
	next  *Node
	prev  *Node
}

func main() {
	args := os.Args[1:]

	if len(args) < 2 {
		fmt.Printf("Expects M followed by list of nodes (containing >= M elements)")
		os.Exit(1)
	}

	m, _ := strconv.Atoi(args[0])
	// Because this is a doubly-linked list, we can keep a reference to a
	// sole 'tail' node and don't even have to have a 'head'.
	var tail Node

	for i, value := range args[1:] {
		intValue, _ := strconv.Atoi(value)

		if i == 0 {
			tail.value = intValue
		} else {
			var previousTail = tail
			tail.value = intValue
			tail.prev = &previousTail
			previousTail.next = &tail
		}
	}

	current := &tail

	for i := 1; i < m; i++ {
		current = current.prev
	}

	if current == nil {
		fmt.Printf("M must be <= number of nodes specified")
		os.Exit(1)
	}

	fmt.Println(current.value)
}

// go run mth-to-last.go 2 42
// go run mth-to-last.go 4 10 200 3 40000 5
