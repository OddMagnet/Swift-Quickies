import Foundation

struct SortedArray<Element>: CustomStringConvertible, RandomAccessCollection {
    private var items = [Element]()
    var sortBefore: (Element, Element) -> Bool

    var count: Int { items.count }
    var description: String { items.description }
    var startIndex: Int { items.startIndex }
    var endIndex: Int { items.endIndex }

    init(comparator: @escaping (Element, Element) -> Bool) {
        self.sortBefore = comparator
    }

    subscript(index: Int) -> Element {
        items[index]
    }

    mutating func insert(_ element: Element) {
        for (i, item) in items.enumerated() {
            if sortBefore(element, item) {
                items.insert(element, at: i)
                return
            }
        }
        items.append(element)
    }

    mutating func remove(at index: Int) {
        items.remove(at: index)
    }
}

extension SortedArray where Element: Comparable {
    init() {
        self.init(comparator: <)
    }
}

