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
            - @ObservedObject, editable
    - ** Global State**: When the data is not owned by any particular view and lives as long as the app lives
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
struct DetailView: View {
    // Local Value, Constant
    let contact = TestData.contact
    // Local Value, @State
    @State private var isEditContactViewPresented = false

    var body: some View {
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
            EditContactView()
        }
    }
}

struct EditContactView: View {
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


//
//
// MARK: - ContentView

struct ContentView: View {
    var body: some View {
        NavigationView {
            DetailView()
                .navigationTitle("DataFlow Example")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
