//
//  ContentView.swift
//  Bookworm
//
//  Created by Vivien on 3/6/23.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) private var dismiss
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                    .foregroundColor(book.rating == 1 ? .red : .blue)
                                
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationBarBackButtonHidden()
                .navigationTitle("Bookworm")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Sign Out"){
                            do {
                                try Auth.auth().signOut()
                                print("Log Out Successful!")
                                dismiss()
                            } catch {
                                print("Error: Could not sign out.")
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddScreen.toggle()
                        } label: {
                            Label("Add Book", systemImage: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView()
                }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        
        //try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
