import Foundation

// MARK: - Regular tree
@_functionBuilder
struct NodeBuilder {
    static func buildBlock<Value>(_ children: Node<Value>...) -> [Node<Value>] {
        children
    }
}

struct Node<Value> {
    var value: Value
    private(set) var children: [Node]

    var count: Int {
        1 + children.reduce(0) { $0 + $1.count }
    }

    init(_ value: Value) {
        self.value = value
        children = []
    }

    init(_ value: Value, children: [Node]) {
        self.value = value
        self.children = children
    }

    init(_ value: Value, @NodeBuilder builder: () -> [Node]) {
        self.value = value
        self.children = builder()
    }

    mutating func add(child: Node) {
        children.append(child)
    }
}

// Ability to compare nodes and make them hashable & codable
extension Node: Equatable where Value: Equatable {}
extension Node: Hashable where Value: Hashable {}
extension Node: Codable where Value: Codable {}

// Add ability to search for a specific node in the tree
extension Node where Value: Equatable {
    func find(_ value: Value) -> Node? {
        if self.value == value { return self }

        for child in children {
            if let match = child.find(value) { return match }
        }

        return nil
    }
}

let root = Node("Reinhard") {
    Node("Michael")
    Node("Martin") {
        Node("Aliya")
        Node("Daimon")
    }
}

print("Regular Tree Testing Output")
print(root)
if let brother = root.find("Martin") {
    print(brother.count)
}
print("")



// MARK: - Binary tree
class BinaryNode<Value> {
    var value: Value
    var left: BinaryNode?
    var right: BinaryNode?

    init(_ value: Value) {
        self.value = value
    }
}

extension BinaryNode: Sequence {
    func makeIterator() -> Array<BinaryNode<Value>>.Iterator {
        Array(self).makeIterator()
    }
}

extension Array {
    // Initialise an array from a binary tree in order (LPR)
    init<T>(_ binaryNode: BinaryNode<T>) where Element == BinaryNode<T> {
        self = [BinaryNode<T>]()

        if let left = binaryNode.left {
            self += Array(left)
        }

        self += [binaryNode]

        if let right = binaryNode.right {
            self += Array(right)
        }
    }
}

extension BinaryNode where Value: Equatable {
    func find(_ search: Value) -> BinaryNode? {
        for node in self {
            if node.value == search {
                return node
            }
        }

        return nil
    }
}

let bRoot = BinaryNode(1)
bRoot.left = BinaryNode(5)
bRoot.right = BinaryNode(3)

bRoot.left?.left = BinaryNode(7)
bRoot.left?.right = BinaryNode(2)

bRoot.right?.left = BinaryNode(6)
bRoot.right?.right = BinaryNode(4)

print("Binary Tree Testing Output")
for node in bRoot {
    print(node.value, terminator: " -> ")
}
