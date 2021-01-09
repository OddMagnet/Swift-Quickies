import Foundation

// indirect makes it so that the enum cases are effectively reference types
indirect enum LinkedListNode<Element> {
    case node(value: Element, next: LinkedListNode<Element>?)

    var value: Element? {
        switch self {
            case .node(let value, _):
                return value
        }
    }
    var next: LinkedListNode<Element>? {
        switch self {
            case .node(_, let next):
                return next
        }
    }
}

struct LinkedList<Element>: ExpressibleByArrayLiteral, Sequence {
    var start: LinkedListNode<Element>?

    init(start: LinkedListNode<Element>) {
        self.start = start
    }

    public init(arrayLiteral elements: Element...) {
        for element in elements.reversed() {
            // create list in reverse, the last elements `next` points to nil,
            // the second to last will point to the last and so on
            start = LinkedListNode.node(value: element, next: start)
        }
    }

    init(array: Array<Element>) {
        for element in array.reversed() {
            start = LinkedListNode.node(value: element, next: start)
        }
    }

    func makeIterator() -> LinkedListIterator<Element> {
        LinkedListIterator(current: start)
    }
}

struct LinkedListIterator<Element>: IteratorProtocol {
    var current: LinkedListNode<Element>?

    mutating func next() -> LinkedListNode<Element>? {
        // ensure that current doesn't change until after it's returned
        defer { current = current?.next }
        return current
    }
}


var third = LinkedListNode.node(value: 5, next: nil)
var second = LinkedListNode.node(value: 3, next: third)
var first = LinkedListNode.node(value: 1, next: second)

let list = LinkedList(start: first)

for node in list {
    print(node.value ?? "n/a")
}
