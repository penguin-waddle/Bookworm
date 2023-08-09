//
//  RegistrationView.swift
//  Bookworm
//
//  Created by Vivien on 8/9/23.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""

    var body: some View {
        VStack {
            TextField("Username", text: $username)
            SecureField("Password", text: $password)
            Button("Register") {
                if registerUser(username: username, password: password) {
                    errorMessage = "Registered Successfully!"
                } else {
                    errorMessage = "Error registering."
                }
            }
            Text(errorMessage)
                .foregroundColor(.red)
        }
        .padding()
    }

    func registerUser(username: String, password: String) -> Bool {
        let newUser = User(context: moc)
        newUser.username = username
        newUser.password = password

        do {
            try moc.save()
            return true
        } catch {
            print("Error saving user: \(error)")
        }
        return false
    }
}


struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
