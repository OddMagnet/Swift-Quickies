import SwiftUI
import PlaygroundSupport

// Property wrapper that writes to disk automatically
@propertyWrapper struct Document: DynamicProperty {
    @State private var value = ""
    private let url: URL

    init(_ filename: String) {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        url = paths[0]

        // try to read in case the file already exists, otherwise use an empty string
        let initialValue = (try? String(contentsOf: url)) ?? ""
        _value = State(wrappedValue: initialValue)
    }

    // Handles the storing and changing of the wrapped value
    var wrappedValue: String {
        get {               // just return the wrapped value as it is
            value
        }
        nonmutating set {   // save the changes to disk and update the value, nonmutating because the underlying struct doesn't change
            do {
                try newValue.write(to: url, atomically: true, encoding: .utf8)
                value = newValue
            } catch {
                value = newValue    // TODO: Remove if used outside of Playground. This is just for text purposes
                print("Failed to save new value to disk")
            }
        }
    }

    // Handles the creation of bindings of the wrapped value
    var projectedValue: Binding<String> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
}

struct ContentView: View {
    @Document("test.txt") var testDocument

    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $testDocument)
                    .frame(width: 300, height: 200)


                Button("Change document") {
                    testDocument = String(Int.random(in: 1...10))
                }
            }
        }
    }
}

PlaygroundPage.current.setLiveView(ContentView())
