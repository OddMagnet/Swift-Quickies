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
    mutating func append(_ newElement: Element) -> Bool {   // using 'newElement' as a parameter name for consistency with Set's insert and Arrays's append function
        // insert into set, check the returned tuple's `inserted` part
        if set.insert(newElement).inserted {
            array.append(newElement)
            return true
        } else {
            return false
        }
    }

    /// Checks if the ordered set contains a member
    /// - Parameter member: The member to check for
    /// - Returns: True if it contains the member, false if not
    func contains(_ member: Element) -> Bool {              // using 'member' as a parameter name for consistency with Set's contains function
        set.contains(member)
    }

    /// Override the synthesized `==` method so Swift only compared the arrays and not the sets as well
    static func ==(lhs: OrderedSet, rhs: OrderedSet) -> Bool {
        return lhs.array == rhs.array
    }
}

extension OrderedSet: RandomAccessCollection {
    var startIndex: Int { array.startIndex }
    var endIndex: Int { array.endIndex }

    subscript(index: Int) -> Element {
        array[index]
    }
}
