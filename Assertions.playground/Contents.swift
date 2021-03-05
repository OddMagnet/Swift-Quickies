import Foundation

// assert() only applies when debugging and thus have no impact on performance in the live app
// Often an assert() is better than a print()
func sum(of numbers: [Double]) -> Double {
    assert(numbers.count > 0, "This function needs some numbers to work with")
    return numbers.reduce(0, { $0 + $1 })
}

sum(of: [1.1, 2.2, 3.3])


// Just as assert(), assertionFailure() only applies when debugging
// it doesn't have a condition anymore and will simply fail the program right away
// assertionFailure() is best used for code that should not be reached by the program anyways
func result(for input: String) {
    switch input {
        case "OddMagnet":
            print("That's your twitter handle")
        case "Michael":
            print("That's your real name")
        default:
            assertionFailure("This input was invalid")
    }
}


// precondition() works a lot like assert() as well, but won't be optimised out of the release build of the app
// wanting to crash the live app might sound weird, but it has it's uses, for example to preserve data integrity
// in the Swift standard library it is used to ensure that ranges have a higher upper than lower bound, for example
extension Array {
    mutating func removeRandom(_ number: Int) {
        precondition(count > number, "It's impossible to remove more elements than the array has")

        for _ in 0 ..< number {
            remove(at: Int.random(in: 0 ..< count))
        }
    }
}


// the counterpart to assertionFailure() is preconditionFailure()
// like precondition() it won't be optimised out of the release build
// unlike those before it, it has a return type - Never -,
// which means the compiler will throw a warning if executable code is placed after it
// this also means that functions that usually return a value don't need to return something made up if a condition isn't met
func updateStatus(to newStatus: String) -> String {
    if newStatus == "active" || newStatus == "inactive" {
        return "Updating status..."
    }

    preconditionFailure("Unknown status: \(newStatus)")
}


// finally, there is fatalError(), which unconditionally crashes the app
// unlike preconditionFailure() there is no build setting that would fatalError() to be ignored
// it's best used when the app absolutely needs to crash at that point, no matter what
// in case of force unwrapping, if an else-block would call fatalError(), then a force unwrap would likely be better
guard let someResource = Bundle.main.url(forResource: "input", withExtension: "json") else {
    fatalError("Failed to locate resource")
}


/* MARK: - Summary
 - assert() should be used often since it doesn't affect performance and ensures that assumptions made about the app state are correct
 - assertionFailure() should be used where code shouldn't be reached, but where it's also no big deal if it happens
 - precondition() anywhere where important checks must happen, in order to keep the user safe
 - the difference between preconditionFailure() and fatalError() is mostly that preconditionFailure() can be ignored via build settings
 */
