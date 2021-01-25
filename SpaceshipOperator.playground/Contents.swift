import Foundation

// Declare the new operator
infix operator <=>

/// The 'Spaceship' operator compares two values and returns if they're the same, ordered ascending or ordered descending
/// - Parameters:
///   - lhs: The left side of the operator
///   - rhs: The right side of the operator
/// - Returns: `.orderedAscending` if `rhs` is greater, `.orderedDescending` if `lhs` is greater or `.orderedSame` if they're equal
func <=><T: Comparable>(lhs: T, rhs: T) -> ComparisonResult {
    if lhs < rhs { return .orderedAscending }
    if lhs > rhs { return .orderedDescending }
    return .orderedSame
}

extension ComparisonResult {
    var stringValue: String {
        switch self {
            case .orderedAscending:
                return "Ordered ascending"
            case .orderedDescending:
                return "Ordered descending"
            default:
                return "Equal"
        }
    }
}
