//
//  LoginView.swift
//  Bookworm
//
//  Created by Vivien on 8/9/23.
//

import CoreData
import SwiftUI

struct LoginView: View {
    @Environment(\.managedObjectContext) var moc
    @Binding var isLoggedIn: Bool

    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""

    var body: some View {
        VStack {
            TextField("Username", text: $username)
            SecureField("Password", text: $password)
            Button("Login") {
                if authenticateUser(username: username, password: password) {
                    isLoggedIn = true
                } else {
                    errorMessage = "Invalid credentials."
                }
            }
            Text(errorMessage)
                .foregroundColor(.red)
        }
        .padding()
    }

    func authenticateUser(username: String, password: String) -> Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username = %@ AND password = %@", username, password)

        do {
            let results = try moc.fetch(fetchRequest)
            if results.count > 0 {
                return true
            }
        } catch {
            print("Error checking credentials: \(error)")
        }
        return false
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLoggedIn: .constant(false))
    }
}

