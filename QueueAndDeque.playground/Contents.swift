import Foundation

struct Queue<Element> {
    private var array = [Element]()
    var first: Element? { array.first }
    var last: Element? { array.last }
    var isEmpty: Bool { array.count == 0 }

    mutating func append(_ element: Element) {
        array.append(element)
    }

    mutating func dequeue() -> Element? {
        isEmpty
            ? nil
            : array.remove(at: 0)
    }
}

struct Deque<Element> {
    private var array = [Element]()
    var first: Element? { array.first }
    var last: Element? { array.last }
    var isEmpty: Bool { array.count == 0 }

    mutating func prepend(_ element: Element) {
        array.insert(element, at: 0)
    }

    mutating func append(_ element: Element) {
        array.append(element)
    }

    mutating func dequeueFront() -> Element? {
        isEmpty
            ? nil
            : array.remove(at: 0)
    }

    mutating func dequeueLast() -> Element? {
        isEmpty
            ? nil
            : array.removeLast()
    }
}


