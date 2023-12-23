//
//  BookViewModel.swift
//  Bookworm
//
//  Created by Vivien on 8/17/23.
//

import Foundation
import CoreData

class BookViewModel: ObservableObject {
    var context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func saveBook(id: UUID?, title: String, author: String, rating: Int16, genre: String, review: String, date: Date) -> Bool {
        let book: Book

        if let id = id, let existingBook = fetchBook(by: id) {
            // Update existing book
            book = existingBook
        } else {
            // Create new book
            book = Book(context: context)
            book.id = UUID()
        }

        book.title = title
        book.author = author
        book.rating = rating
        book.genre = genre
        book.review = review
        book.date = date

        do {
            try context.save()
            print("Book saved successfully.")
            return true
        } catch {
            print("Error saving book: \(error.localizedDescription)")
            return false
        }
    }

    private func fetchBook(by id: UUID) -> Book? {
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        return (try? context.fetch(request))?.first
    }
}

