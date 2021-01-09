import Foundation

class LinkedListNode<Element> {
    var value: Element
    var next: LinkedListNode?

    init(value: Element) {
        self.value = value
        self.next = nil
    }
}

class LinkedList<Element> {
    var start: LinkedListNode<Element>?
}
