//
//  ListView.swift
//  Bookworm
//
//  Created by Vivien on 3/6/23.
//

import SwiftUI
import CoreData

struct ListView: View {
    @FetchRequest(entity: Book.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Book.title, ascending: true)])
    private var books: FetchedResults<Book> // Make sure Book is NSManagedObject

    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) private var dismiss

    @State private var showingAddScreen = false

    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.objectID) { book in // Use objectID for identification
                    NavigationLink(destination: DetailView(book: book)) { // Directly pass the book object
                        HStack {
                            EmojiRatingView(rating: book.rating) // Pass rating as a value
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
            .navigationTitle("Books")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddScreen.toggle() }) {
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
        try? moc.save()
    }
}

