//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Vivien on 3/6/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct BookwormApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
                ContentView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

