
import Foundation
import LeoQL
import Fluent
import FluentSQLite

class User: Object {
    let connectable: DatabaseConnectable
    let user: UserModel

    let id: Int
    let firstname: String
    let lastname: String
    let email: String

    init(connectable: DatabaseConnectable, user: UserModel) {
        self.connectable = connectable
        self.user = user
        self.id = user.id!
        self.firstname = user.firstname
        self.lastname = user.lastname
        self.email = user.email
    }

    func todos() throws -> Future<[Todo]> {
        return try user
            .todos
            .query(on: connectable)
            .all()
            .map { $0.map { Todo(connectable: self.connectable, todo: $0) } }
    }
}

final class UserModel: SQLiteModel {
    static let idKey: WritableKeyPath<UserModel, Int?> = \.id

    var id: Int?
    var firstname: String
    var lastname: String
    var email: String

    var todos: Children<UserModel, TodoModel> {
        return children(\.authorID)
    }

    init(id: String,
         firstname: String,
         lastname: String,
         email: String) {

        self.firstname = firstname
        self.lastname = lastname
        self.email = email
    }
}
