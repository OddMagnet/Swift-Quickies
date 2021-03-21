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
        // Set initial bounds
        var lowerBound = 0
        var upperBound = items.count
        var middleIndex = lowerBound + (upperBound - lowerBound) / 2

        while lowerBound < upperBound {
            // check if the new element belongs in the lower half
            if sortBefore(element, items[middleIndex]) {
                // if so, set the new upperBound
                upperBound = middleIndex
            // otherwise it belongs in the upper half
            } else {
                // so set the new lowerBound
                lowerBound = middleIndex + 1
            }
            // finally calculate the new middleIndex
            middleIndex = lowerBound + (upperBound - lowerBound) / 2
            // as soon as the lower and upperBound are the same the index is found and the while loop end
        }
        // and the new element is inserted
        items.insert(element, at: middleIndex)
    }

    mutating func remove(at index: Int) {
        items.remove(at: index)
    }

    mutating func sorted() -> [Element] {
        return items
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

var array = SortedArray<Int>()
for _ in 1...20 {
    array.insert(Int.random(in: 1...200))
}
print(array)
