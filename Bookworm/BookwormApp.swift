//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Vivien on 3/6/23.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    @State private var isLoggedIn: Bool = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                ContentView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
            }
        }
    }
}

