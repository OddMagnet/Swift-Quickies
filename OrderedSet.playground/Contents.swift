import Foundation

struct OrderedSet<Element: Hashable>: Equatable {
    public private(set) var array = [Element]()
    private var set = Set<Element>()
    var count: Int { array.count }
    var isEmpty: Bool { array.isEmpty }

    init() { }

    init(_ array: [Element]) {
        for element in array {
            append(element)
        }
    }

    /// Appends a `newElement` to the set  if it does not contain it yet
    /// - Parameter newElement: The element to append
    /// - Returns: True if the element was appended, false if the set already contains it, the result is discardable
    @discardableResult
    mutating func append(_ newElement: Element) -> Bool {   // using 'newElement' as a parameter name since Set's insert and Arrays's append function do so as well
        // insert into set, check the returned tuple's `inserted` part
        if set.insert(newElement).inserted {
            array.append(newElement)
            return true
        } else {
            return false
        }
    }

    func contains(_ member: Element) -> Bool {              // using 'member' as a parameter name since Set's contains function does so as well
        set.contains(member)
    }
}
