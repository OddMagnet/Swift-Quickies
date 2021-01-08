import Foundation

struct Stack<Element> {
    private var array = [Element]()
    var count: Int { array.count }
    var isEmpty: Bool { array.isEmpty }

    init(_ items: [Element]) {
        self.array = items
    }
    init() { }

    /// Pushes a new element onto the stack
    /// - Parameter element: The element to be pushed onto the stack
    mutating func push(_ element: Element) {
        array.append(element)
    }

    /// Returns and removes (pops) the last element of the stack
    /// - Returns: The last element of the stack or nil if the stack is empty
    mutating func pop() -> Element? {
        array.popLast()
    }

    /// Returns the last element of the stack without removing it
    /// - Returns: The last element of the stack or nil if the stack is empty
    func peek() -> Element? {
        array.last
    }
}

/// Adds conformance to `ExpressibleByArrayLiteral`, which allows assigning an array directly to the stack
extension Stack: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.array = elements
    }
}

/// Adds conformance to `CustomDebugStringConvertible`, which helps stopping leaking of the internal array,
/// by customizing how a variable of the `Stack` type is printed
extension Stack: CustomDebugStringConvertible {
    var debugDescription: String {
        var result = "["
        var firstElement = true

        for element in array {
            if firstElement { firstElement = false }
            else { result += ", " }

            // get the debug representation of the variable
            // and 'print' it to the result variable
            debugPrint(element, terminator: "", to: &result)
        }

        result += "]"
        return result
    }
}
