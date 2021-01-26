import Foundation

// create the individual components
var components = PersonNameComponents()
components.givenName = "James"
components.middleName = "Alan"
components.familyName = "Hetfield"
components.nickname = "Papa Het"



// create the formatter and print the name in various formats
let formatter = PersonNameComponentsFormatter()

formatter.style = .abbreviated
print("Abbreviated name: \(formatter.string(from: components))")    // abbreviated style returns the given and family name initials

formatter.style = .default
print("Default name: \(formatter.string(from: components))")        // default style returns what would be normal for the users locale

formatter.style = .long
print("Long name: \(formatter.string(from: components))")           // long style returns given, middle and family name

formatter.style = .medium
print("Medium name: \(formatter.string(from: components))")         // medium style returns the given and family name

formatter.style = .short
print("Short style: \(formatter.string(from: components))")         // short style returns the nickname



// it can also create components from a given string
if let james = formatter.personNameComponents(from: "James Alan Hetfield") {
    print(james)
}
// but this should be used as a fallback, e.g. when receiving data from network calls
// since there are cases it doesn't handle well
if let adele = formatter.personNameComponents(from: "Adele Laurie Blue Adkins") {
    print("Wrong: \t\t\(adele)")
    print("Correct:\tgivenName: Adele middleName: Laurie Blue familyName: Adkins")
}
