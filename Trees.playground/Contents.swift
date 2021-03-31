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



// MARK: - Binary Search Tree
class BSTNode<Value: Comparable> {
    var value: Value
    var count: Int = 1
    private(set) var left: BSTNode?
    private(set) var right: BSTNode?

    init(_ value: Value) {
        self.value = value
    }

    func insert(_ newValue: Value) {
        if newValue < value {                               // check left side
            if left == nil { left = BSTNode(newValue) }     // create left node if it doesn't exist
            else { left?.insert(newValue) }                 // if it does, try to insert from there
        } else if newValue > value {                        // check right side
            if right == nil { right = BSTNode(newValue) }   // create right node if it doesn't exist
            else { right?.insert(newValue) }                // if it does, try to insert from there
        } else {                                            // if the newValue is neither more or less
            count += 1                                      // then increase the count
        }
    }
}

extension BSTNode: Sequence {
    func makeIterator() -> Array<BSTNode<Value>>.Iterator {
        Array(self).makeIterator()
    }
}

extension Array {
    // Initialise an array from a binary tree in order (LPR)
    init<T>(_ binaryNode: BSTNode<T>) where Element == BSTNode<T> {
        self = [BSTNode<T>]()

        if let left = binaryNode.left {
            self += Array(left)
        }

        self += [binaryNode]

        if let right = binaryNode.right {
            self += Array(right)
        }
    }
}

extension BSTNode where Value: Equatable {
    func find(_ search: Value) -> BSTNode? {
        for node in self {
            if node.value == search {
                return node
            }
        }

        return nil
    }
}

let bRoot = BSTNode(4)
bRoot.insert(5)
bRoot.insert(3)

bRoot.insert(7)
bRoot.insert(2)

bRoot.insert(6)
bRoot.insert(1)

print("Binary Tree Testing Output")
for node in bRoot {
    print(node.value, terminator: " -> ")
}
