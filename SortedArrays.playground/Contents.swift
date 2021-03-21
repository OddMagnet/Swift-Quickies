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

    // NOTE: - the `warn_unqualified_access` is used so Swift gives a warning when the normal min()/max() functions are used
    // instead of the optimised versions, which are called via self.min() and self.max()
    /// Optimised min() version, returns the first element of the sorted array
    /// - Returns: The element with the lowest value
    @warn_unqualified_access func min() -> Element? {
        items.first
    }

    /// Optimised max() version, returns the last element of the sorted array
    /// - Returns: The element with the highest value
    @warn_unqualified_access func max() -> Element? {
        items.last
    }
}

extension SortedArray where Element: Comparable {
    init() {
        self.init(comparator: <)
    }
}

