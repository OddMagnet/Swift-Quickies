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

extension Deque where Element: Equatable {
    // using inlinable would give a small performance boost at the cost
    // of a slightly increased binary. Instead of a function calling a
    // function the compiler would place the contents of the called function
    // directly into this one. Since Apple's implementation is unlikely
    // to change won't cause any problems later on
    // (especially not since this is just a playground for practice)
    @inlinable
    func firstIndex(of element: Element) -> Int? {
        array.firstIndex(of: element)
    }

    @inlinable
    func contains(_ element: Element) -> Bool {
        array.contains(element)
    }
}

protocol Prioritized {
    var priority: Int { get }
}

struct Work<Element>: Prioritized {
    let data: Element
    let priority: Int
}

extension Queue where Element: Prioritized {
    mutating func dequeue() -> Element? {
        guard !isEmpty else { return nil }

        var choiceIndex = 0
        var choice = array[choiceIndex]

        for (index, element) in array.enumerated() {
            if element.priority > choice.priority {
                choice = element
                choiceIndex = index
            }
        }

        return array.remove(at: choiceIndex)
    }
}
