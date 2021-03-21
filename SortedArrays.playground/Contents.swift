import Foundation

struct SortedArray<Element>: CustomStringConvertible, RandomAccessCollection where Element: Comparable {
    private var items = [Element]()

    var count: Int { items.count }
    var description: String { items.description }
    var startIndex: Int { items.startIndex }
    var endIndex: Int { items.endIndex }

    subscript(index: Int) -> Element {
        items[index]
    }

    mutating func insert(_ element: Element) {
        for (i, item) in items.enumerated() {
            if item >= element {
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

