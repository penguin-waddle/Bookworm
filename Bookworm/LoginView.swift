//
//  LoginView.swift
//  Bookworm
//
//  Created by Vivien on 8/9/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    enum Field {
        case email, password
    }

    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @FocusState private var focusField: Field? 

    var body: some View {
        NavigationStack {
            Group {
                TextField("Username", text: $username)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                
                SecureField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.done)
            }
            .textFieldStyle(.roundedBorder)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.5), lineWidth: 2)
            }
            .padding(.horizontal)
            
            HStack {
                Button {
                    register()
                } label: {
                    Text("Sign Up")
                }
                .padding(.trailing)
                
                Button {
                    login()
                } label: {
                    Text("Log In")
                }
                .padding(.leading)

            }
            .buttonStyle(.borderedProminent)
            .tint(.accentColor)
            .font(.title2)
            .padding(.top)
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert(alertMessage, isPresented: $showingAlert, actions: {
            Button("OK", role: .cancel) {}
        })
        .padding()
    }

    func register() {
        Auth.auth().createUser(withEmail: username, password: password) { result, error in
            if let error = error {
                print("Registration Error: \(error.localizedDescription)")
                alertMessage = "Registration Error: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("You are registered!")
                //more code load contentview
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: username, password: password) { result, error in
            if let error = error {
                print("Login Error: \(error.localizedDescription)")
                alertMessage = "Login Error: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("You are logged in!")
                //more code load contentview
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

