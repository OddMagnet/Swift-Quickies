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
            DetailView(dataController: dataController)
        }
    }
}
