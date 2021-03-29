import Cocoa

struct Node<Value> {
    var value: Value
    private(set) var children: [Node]

    init(_ value: Value) {
        self.value = value
        children = []
    }

    init(_ value: Value, children: [Node]) {
        self.value = value
        self.children = children
    }

    mutating func add(child: Node) {
        children.append(child)
    }
}

// Ability to compare nodes and make them hashable & codable
extension Node: Equatable where Value: Equatable {}
extension Node: Hashable where Value: Hashable {}
extension Node: Codable where Value: Codable {}

var michael = Node("Michael")

var martin = Node("Martin")
let aliya = Node("Aliya")
let daimon = Node("Daimon")
martin.add(child: aliya)
martin.add(child: daimon)

var root = Node("Reinhard")
root.add(child: michael)
root.add(child: martin)

print(root)
