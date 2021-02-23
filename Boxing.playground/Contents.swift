import Foundation

// A very basic box
final class Box<Type> {
    var value: Type

    init(_ value: Type) {
        self.value = value
    }
}

let name = "OddMagnet"
var nameCopy = name
let boxedName = Box(name)
let firstBoxCopy = boxedName
let secondBoxCopy = boxedName

nameCopy = "Michael"
secondBoxCopy.value = "Michael"

// changing the value of a boxed variable changes it for all holders, not so for normal structs
print("name:\t\t \(name)")
print("nameCopy:\t \(nameCopy)")
print("boxedName:\t \(boxedName)")
print("firstCopy:\t \(firstBoxCopy)")
print("secondCopy:\t \(secondBoxCopy)")



//
// Extending the box with conditional conformance
//

// Make the box work better with `print()`
extension Box: CustomStringConvertible where Type: CustomStringConvertible {
    var description: String { value.description }
}

// Make the box equatable and comparable
extension Box: Equatable where Type: Equatable {
    static func ==(lhs: Box, rhs: Box) -> Bool {
        lhs.value == rhs.value
    }
}
extension Box: Comparable where Type: Comparable {
    static func <(lhs: Box, rhs: Box) -> Bool {
        lhs.value < rhs.value
    }
}

// Make the box hashable
extension Box: Hashable where Type: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

// Make the box identifiable
extension Box: Identifiable where Type: Identifiable {
    var id: Type.ID { value.id }
}



//
// Adding some new functionality
//

// Make the Box Codable (2 extensions in case a type only conforms to one of the protocols)
extension Box: Encodable where Type: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
}
extension Box: Decodable where Type: Decodable {
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(Type.self)
        self.init(value)
    }
}



//
// Bonus, mapping once type of box to another
//

extension Box {
    func map<OtherType>(_ function: (Type) throws -> OtherType) rethrows -> Box<OtherType> {
        Box<OtherType>(try function(value))
    }
}
