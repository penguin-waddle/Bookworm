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
    @State private var buttonsDisabled = true
    @State private var presentSheet = false
    @FocusState private var focusField: Field?

    var body: some View {
       VStack {
            Group {
                TextField("Username", text: $username)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .focused($focusField, equals: .email)
                    .onSubmit {
                        focusField = .password
                    }
                    .onChange(of: username) { _ in
                        enableButtons()
                    }
                
                SecureField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.done)
                    .focused($focusField, equals: .password)
                    .onSubmit {
                        focusField = nil //dismiss keyboard
                    }
                    .onChange(of: password) { _ in
                        enableButtons()
                    }
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
            .disabled(buttonsDisabled)
            .buttonStyle(.borderedProminent)
            .tint(.accentColor)
            .font(.title2)
            .padding(.top)

        }
        .alert(alertMessage, isPresented: $showingAlert, actions: {
            Button("OK", role: .cancel) {}
        })
        .onAppear {
            //skip log in screen if there is a current user
            if Auth.auth().currentUser != nil {
                print("You are logged in!")
                presentSheet = true
            }
        }
        .fullScreenCover(isPresented: $presentSheet) {
            ListView()
        }
        .padding()
    }
    
    func enableButtons() {
        let emailIsGood = username.count >= 6 && username.contains("@")
        let passwordIsGood = password.count >= 6
        buttonsDisabled = !(emailIsGood && passwordIsGood)
    }

    func register() {
        Auth.auth().createUser(withEmail: username, password: password) { result, error in
            if let error = error {
                print("Registration Error: \(error.localizedDescription)")
                alertMessage = "Registration Error: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("You are registered!")
                presentSheet = true
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
                presentSheet = true
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

