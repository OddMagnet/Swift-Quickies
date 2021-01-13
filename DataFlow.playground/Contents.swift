import SwiftUI
import PlaygroundSupport

/**
 This Playground is used to explore the different mechanisms of passing data between views that SwiftUI offers
 - **Local State**: When the data is owned by the current view, only passed to children and lives only as long as the view owns it
    - *Local Value*: e.g. State of UI, data entered by User
        - Constant, if the data won't change
        - @State, if the data needs to be editable
    - *Local Object*: e.g. model that performs network requests or stores data
        - @StateObject, editable
 - **Shared State**: When the data is owned by an ancestor and only shared with the current view
    - *Shared Value*: e.g. simple information, a piece of some data instance the current view needs to display
        - Regular Property, if the data won't change
        - @Binding, if the data needs to be editable
    - *Shared Object*: e.g. model type with reference semantics, like Core Data's managed objects
        - @ObservedObject, editable
 - ** Global State**: When the data is not owned by any particular view and lives as long as the app lives
    - *Global Value*: e.g. settings, dark mode, accent color
        - @Environment, not editable
    - *Global Object*: e.g. a controller that handles network requests or contains the app state
        - @EnvironmentObject, editable
 */

struct Contact {
    var photoName: String
    var firstName: String
    var middleName: String?
    var lastName: String
    var email: String
    var phone: String
}

struct TestData {
    static let contact = Contact(
        photoName: "person",
        firstName: "Michael",
        middleName: nil,
        lastName: "Brünen",
        email: "oddmagnetdev@gmail.com",
        phone: "+49 12345 6789"
    )
}

struct ContentView: View {
    @State private var contact = TestData.contact

    var body: some View {
        Image(systemName: contact.photoName)
    }
}

PlaygroundPage.current.setLiveView(ContentView().frame(width: 400, height: 700))
