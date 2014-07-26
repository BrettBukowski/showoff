import Foundation

// Problem: Balanced delimiters
// <https://www.hackerrank.com/contests/programming-interview-questions/challenges/balanced-delimiters>
//
// Discussion: This is a classic "stack problem."
// Similar to palindrome or reverse Polish notation
// problems, the key is to use a stack to maintain
// the balance. Add in some input checking and
// we're set.

// Quick lil' stack implementation.
class Stack {
    private var list: [Character] = []

    func push (char: Character) {
        list.insert(char, atIndex: 0)
    }

    func pop () -> Character? {
        return list.removeAtIndex(0)
    }

    func peek () -> Character? {
        if list.count > 0 {
            return list[0]
        }
        return nil
    }

    func empty () -> Bool {
        return list.count == 0
    }
}

func balancedBrackets(input: String) -> Bool {
    let stack = Stack()
    // Anything other than these characters is ignored.
    let validCharacters = "{}()[]"
    // Given a closing bracket, the char at the top of
    // the stack should be its opener.
    let delimiters = [
        "}": "{",
        "]": "[",
        ")": "(",
    ]
    var invalidCharactersFound = 0

    for char in input {
        let charAsString = String(char)
        if validCharacters.rangeOfString(charAsString) {
            let delimiter = stack.peek()
            let matchedClosingDelimiter = delimiters[charAsString]

            if delimiter && matchedClosingDelimiter && matchedClosingDelimiter! == String(delimiter!) {
                // Found our balanced match.
                stack.pop()
                continue
            }
            stack.push(char)
        } else {
            invalidCharactersFound++
        }
    }

    // Make sure that the checking algorithm wasn't entirely bypassed if
    // input is an empty string or consists solely of invalid characters.
    return stack.empty() && invalidCharactersFound != input.utf16Count
}

let testCases = [
    "!": false,
    "":  false,
    "(": false,
    "[)": false,
    "[]]": false,
    "(((]": false,
    "((())": false,
    "[({)]": false,
    "()": true,
    "(())": true,
    "(bcb)": true,
    "()[]{}": true,
    "([{}])": true,
    "{this}(isn't)": true,
    "([]{})": true,
    "()[]{}([{}])([]{})": true,
    "()[]{} ([{}]) ([]{})": true,
]

for (test, expected) in testCases {
    println("Test: \(test)    -> \(expected)")
    assert(balancedBrackets(test) == expected)
}
