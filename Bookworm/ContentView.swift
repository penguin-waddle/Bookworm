//
//  ContentView.swift
//  Bookworm
//
//  Created by Vivien on 8/16/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ProfileView()
                .tabItem() {
                    Image(systemName:"person")
                    Text("Profile")
                }
            
            ListView()
                .tabItem() {
                    Image(systemName:"book")
                    Text("Home")
                }
            
            ListView()
                .tabItem() {
                    Image(systemName:"person.2")
                    Text("Friends")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
