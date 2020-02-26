
import Foundation
import LeoQL
import Fluent
import FluentSQLite

final class Todo: Object, SQLiteModel {
    static let idKey: WritableKeyPath<Todo, Int?> = \.id

    var id: Int?

    @Ignore
    var authorID: Int

    var title: String
    var completed: Bool

    var author: Parent<Todo, User> {
        return parent(\.authorID)
    }

    init(authorID: Int, title: String, completed: Bool) {
        self.authorID = authorID
        self.title = title
        self.completed = completed
    }
}
