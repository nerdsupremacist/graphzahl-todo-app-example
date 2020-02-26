
import Foundation
import LeoQL
import Fluent
import FluentSQLite

final class User: Object, SQLiteModel {
    static let idKey: WritableKeyPath<User, Int?> = \.id

    var id: Int?
    var firstname: String
    var lastname: String
    var email: String?

    var todos: Children<User, Todo> {
        return children(\.authorID)
    }

    init(id: String,
         firstname: String,
         lastname: String,
         email: String?) {

        self.firstname = firstname
        self.lastname = lastname
        self.email = email
    }
}
