//
//  DataFlowApp.swift
//  DataFlow
//
//  Created by Michael Brünen on 14.01.21.
//

import SwiftUI

@main
struct DataFlowApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            DetailView()
                .environmentObject(dataController)
        }
    }
}

class DataController: ObservableObject {
    // Shared Object, useable in other Views via the @StateObject or @ObservedObject wrappers
    // in `DataFlowApp.swift` a dataController variable is created with @StateObject
    // and then shared to decendant views via @ObservedObject
    @Published var contact = TestData.contact
}
