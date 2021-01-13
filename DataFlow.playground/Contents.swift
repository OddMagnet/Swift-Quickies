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
 The playground will only commented in places where one of the different Data Flow types is used
 */

struct Contact {
    var photo: UIImage
    var fullName: String
    var nickName: String
    var email: String
    var phone: String
}

struct TestData {
    static let contact = Contact(
        photo: UIImage(systemName: "person")!,
        fullName: "Michael Brünen",
        nickName: "OddMagnet",
        email: "oddmagnetdev@gmail.com",
        phone: "0123456789"
    )
}

// MARK: - Shared State, Shared Value, Regular Property
struct RoundImage: View {
    // A simple stored property, passed down from another view
    let image: UIImage

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .clipShape(Circle())
            .frame(width: 150, height: 150)
            .overlay(
                Circle()
                    .stroke(Color.black, lineWidth: 2)
            )
            .padding(.vertical, 20)
    }
}

struct Header: View {
    // Again, simple stored properties, passed down from another view
    let image: UIImage
    let name: String
    let nickName: String

    var body: some View {
        VStack {
            RoundImage(image: image)
            Text(name)
                .font(.title)
                .bold()
            Text(nickName)
                .foregroundColor(.secondary)
        }
        .padding(.bottom, 20)
    }
}

struct Row: View {
    // And one more time, all simple stored properties, passed down from another view
    let label: String
    let text: String
    let destination: URL

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.footnote)
                .bold()
            Link(text, destination: destination)
                .buttonStyle(BorderlessButtonStyle())
        }
        .padding(.top, 8)
    }
}

struct DetailView: View {
    let contact = TestData.contact

    var body: some View {
        VStack(alignment: .leading) {
            Header(
                image: contact.photo,
                name: contact.fullName,
                nickName: contact.nickName
            )
            Row(
                label: "Email",
                text: contact.email,
                destination: URL(string: "mailto:\(contact.email)")!
            )
            Row(
                label: "Phone",
                text: contact.phone,
                destination: URL(string: "tel:\(contact.phone)")!
            )
        }
    }
}

// MARK: - Local State, Local Value, @State
struct EditContactView: View {
    // A simple local source of truth for temporary data, editable for the user
    @State private var draft = TestData.contact

    var body: some View {
        VStack {
            RoundImage(image: draft.photo)
        }
    }
}

struct ContentView: View {
    var body: some View {
            DetailView()
//            EditContactView()
    }
}

PlaygroundPage.current.setLiveView(ContentView().frame(width: 400, height: 700))
