//
//  AddBookView.swift
//  Bookworm
//
//  Created by Vivien on 3/6/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    @State private var date = Date.now

    let genres = ["Fantasy", "Horror","Kids","Mystery","Poetry","Romance","Thriller"]

    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    TextEditor(text: $review)
                    RatingView(rating:$rating)
                } header: {
                    Text("Write a review")
                }

                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        newBook.date = date

                        try? moc.save()
                        dismiss()
                    }
                }
                .disabled(validInput == false)
            }
            .navigationTitle("Add Book")
        }
    }

    var validInput: Bool {
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }

        return true
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}

//import SwiftUI
//
//struct AddBookView: View {
//    @EnvironmentObject var bookVM: BookViewModel
//    @State var book: Book
//    @Environment(\.dismiss) private var dismiss
//    
//    let genres = ["Fantasy", "Horror","Kids","Mystery","Poetry","Romance","Thriller"]
//    
//    var body: some View {
//        NavigationView {
//            Form {
//                Section {
//                    TextField("Name of book", text: $book.title)
//                    TextField("Author's name", text: $book.author)
//                }
//                .disabled(validInput == false)
//            }
//            .navigationTitle("Add Book")
//        }
//        .navigationBarBackButtonHidden(book.id == nil)
//        .toolbar {
//            if book.id == nil { //New book, display cancel and save buttons
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Cancel") {
//                        dismiss()
//                    }
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Save") {
//                        Task {
//                            let success = await bookVM.saveBook(book: book)
//                            if success {
//                                dismiss()
//                            } else {
//                                print("Error saving book!")
//                            }
//                        }
//                        dismiss()
//                    }
//                }
//            }
//        }
//        
//        var validInput: Bool {
//            if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
//                return false
//            }
//
//            return true
//        }
//    }
//}
//
//struct AddBookView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            AddBookView(book: Book())
//                .environmentObject(BookViewModel())
//        }
//    }
//}
