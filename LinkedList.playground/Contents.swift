import Foundation

class LinkedListNode<Element> {
    var value: Element
    var next: LinkedListNode?

    init(value: Element, next: LinkedListNode<Element>? = nil) {
        self.value = value
        self.next = next
    }
}

class LinkedList<Element>: ExpressibleByArrayLiteral, Sequence {
    var start: LinkedListNode<Element>?

    init(start: LinkedListNode<Element>) {
        self.start = start
    }

    required public init(arrayLiteral elements: Element...) {
        for element in elements.reversed() {
            // create list in reverse, the last elements `next` points to nil,
            // the second to last will point to the last and so on
            start = LinkedListNode(value: element, next: start)
        }
    }

    init(array: Array<Element>) {
        for element in array.reversed() {
            start = LinkedListNode(value: element, next: start)
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
