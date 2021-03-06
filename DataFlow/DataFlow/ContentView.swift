//
//  ContentView.swift
//  DataFlow
//
//  Created by Michael Brünen on 14.01.21.
//

import SwiftUI

// MARK: - Overview
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
            - @ObservedObject, editable, equivalent to @Binding, but for Objects
    - ** Global State**: When the data is not owned by any particular view and lives as long as the app lives, does not need to be passed through each view, instead can be "passed" once and is then available in the whole tree, from the owning view downwards
        - *Global Value*: e.g. settings, dark mode, accent color
            - @Environment, not editable
        - *Global Object*: e.g. a controller that handles network requests or contains the app state
            - @EnvironmentObject, editable
 The playground will only commented in places where one of the different Data Flow types is used
 Additionally `MARK:` comments are used for broad navigation
 */

//
//
// MARK: - Local State
struct LocalStateDetailView: View {
    // Local Value, Constant
    let contact = TestData.contact
    // Local Value, @State
    @State private var isEditContactViewPresented = false

    var body: some View {
        NavigationView {
            List {
                Header(
                    image: contact.photo,
                    name: contact.fullName,
                    nickName: contact.nickName
                )
                .frame(maxWidth: .infinity)
                Row(
                    label: "E-Mail",
                    text: contact.email,
                    destination: URL(string: "mailto:\(contact.email)")!
                )
                Row(
                    label: "Phone",
                    text: contact.phone,
                    destination: URL(string: "tel:\(contact.phone)")!
                )
            }
            .listStyle(PlainListStyle())
            .toolbar {
                Button("Edit", action: { isEditContactViewPresented = true} )
            }
            .popover(isPresented: $isEditContactViewPresented) {
                LocalStateEditContactView()
            }
            .navigationTitle("DataFlow Examples")
        }
    }
}

struct LocalStateEditContactView: View {
    // Local Value, @State
    @State private var draft = TestData.contact

    var body: some View {
        List {
            RoundImage(image: draft.photo)
                .padding(.bottom, 20)
            VStack(alignment: .leading) {
                EditableRow(title: "Name", text: $draft.fullName)
                EditableRow(title: "Nickname", text: $draft.nickName)
                EditableRow(title: "E-Mail", text: $draft.email)
                EditableRow(title: "Phone", text: $draft.phone)
            }
        }
    }
}

/* DataFlowApp.swift has an example for the @StateObject wrapper
@main
struct DataFlowApp: App {
    // Local Object, @StateObject, passed down the tree
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            DetailView()
                .environmentObject(dataController)
        }
    }
}
*/

//
//
// MARK: - Shared State
struct RoundImage: View {
    // Shared Value, Regular Property
    let image: UIImage

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .clipShape(Circle())
            .frame(width: 150, height: 150)
            .frame(maxWidth: .infinity)
            .overlay(
                Circle()
                    .stroke(Color.black, lineWidth: 2)
            )
            .padding(.vertical, 15)
    }
}

struct Header: View {
    // Shared Values, Regular Properties
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
    // Shared Values, Regular Properties
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

struct EditableRow: View {
    let title: String
    // Shared Value, @Binding
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.footnote)
                .bold()
            TextField("", text: $text)
        }
        .padding(.top, 8)
    }
}

struct SharedStateDetailView: View {
    // Shared Object with the @ObservedObject wrapper, passed from `DataFlowApp.swift`
    @ObservedObject var dataController: DataController
    @State private var isEditContactViewPresented = false

    // computed property for easier access
    var contact: Contact { dataController.contact }

    var body: some View {
        NavigationView {
            List {
                Header(
                    image: contact.photo,
                    name: contact.fullName,
                    nickName: contact.nickName
                )
                .frame(maxWidth: .infinity)
                Row(
                    label: "E-Mail",
                    text: contact.email,
                    destination: URL(string: "mailto:\(contact.email)")!
                )
                Row(
                    label: "Phone",
                    text: contact.phone,
                    destination: URL(string: "tel:\(contact.phone)")!
                )
            }
            .listStyle(PlainListStyle())
            .toolbar {
                Button("Edit", action: { isEditContactViewPresented = true} )
            }
            .fullScreenCover(isPresented: $isEditContactViewPresented) {
                NavigationView {
                    EditContactView()
                }
            }
            .navigationTitle("DataFlow Examples")
        }
    }
}

//
//
// MARK: - Global State
struct DetailView: View {
    // Global Object, available in the whole tree (from the ancestor view that shared it down),
    // accessible with @EnvironmentObject wrapper
    @EnvironmentObject private var dataController: DataController

    @State private var isEditContactViewPresented = false

    var contact: Contact { dataController.contact }

    var body: some View {
        NavigationView {
            List {
                Header(
                    image: contact.photo,
                    name: contact.fullName,
                    nickName: contact.nickName
                )
                .frame(maxWidth: .infinity)
                Row(
                    label: "E-Mail",
                    text: contact.email,
                    destination: URL(string: "mailto:\(contact.email)")!
                )
                Row(
                    label: "Phone",
                    text: contact.phone,
                    destination: URL(string: "tel:\(contact.phone)")!
                )
            }
            .listStyle(PlainListStyle())
            .toolbar {
                Button("Edit", action: { isEditContactViewPresented = true} )
            }
            .popover(isPresented: $isEditContactViewPresented) {
                NavigationView {
                    EditContactView()
                }
            }
            .navigationTitle("DataFlow Examples")
        }
    }
}

struct EditContactView: View {
    @State private var draft: Contact = TestData.contact

    // Global Value available in the whole tree (from the ancestor view that shared it down),
    // accessible with @Environment wrapper
    @Environment(\.presentationMode) private var presentationMode

    // Global Object, available in the whole tree (from the ancestor view that shared it down),
    // accessible with @EnvironmentObject wrapper
    @EnvironmentObject private var dataController: DataController



    var body: some View {
        List {
            RoundImage(image: draft.photo)
                .padding(.bottom, 20)
            VStack(alignment: .leading) {
                EditableRow(title: "Name", text: $draft.fullName)
                EditableRow(title: "Nickname", text: $draft.nickName)
                EditableRow(title: "E-Mail", text: $draft.email)
                EditableRow(title: "Phone", text: $draft.phone)
            }
        }
        .onAppear { draft = dataController.contact  }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel", action: cancel)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save", action: save)
            }
        }
    }

    func save() {
        dataController.contact = Contact(
            photo: draft.photo,
            fullName: draft.fullName,
            nickName: draft.nickName,
            email: draft.email,
            phone: draft.phone
        )
        presentationMode.wrappedValue.dismiss()
    }

    func cancel() {
        presentationMode.wrappedValue.dismiss()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
            .environmentObject(DataController())
    }
}
