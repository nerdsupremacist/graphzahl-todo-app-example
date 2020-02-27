
import Foundation
import LeoQL
import Fluent
import FluentSQLite

class Todo: Object {
    let connectable: DatabaseConnectable
    let todo: TodoModel

    let id: Int
    let title: String
    let completed: Bool

    init(connectable: DatabaseConnectable, todo: TodoModel) {
        self.connectable = connectable
        self.todo = todo
        self.id = todo.id!
        self.title = todo.title
        self.completed = todo.completed
    }

    func author() -> Future<User> {
        return todo.author.get(on: connectable).map { User(connectable: self.connectable, user: $0) }
    }
}

final class TodoModel: SQLiteModel {
    static let idKey: WritableKeyPath<TodoModel, Int?> = \.id

    var id: Int?

    @Ignore
    var authorID: Int

    var title: String
    var completed: Bool

    var author: Parent<TodoModel, UserModel> {
        return parent(\.authorID)
    }

    init(authorID: Int, title: String, completed: Bool) {
        self.authorID = authorID
        self.title = title
        self.completed = completed
    }
}
