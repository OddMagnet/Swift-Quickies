import Foundation

class LinkedListNode<Element> {
    var value: Element
    var next: LinkedListNode?

    init(value: Element, next: LinkedListNode<Element>? = nil) {
        self.value = value
        self.next = next
    }
}

class LinkedList<Element>: ExpressibleByArrayLiteral {
    var start: LinkedListNode<Element>?

    required public init(arrayLiteral elements: Element...) {
        for element in elements.reversed() {
            // create list in reverse, the last elements `next` points to nil,
            // the second to last will point to the last and so on
            start = LinkedListNode(value: element, next: start)
        }
    }
}
