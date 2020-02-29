
import Foundation
import LeoQL
import Fluent
import FluentSQLiteDriver

final class User: Object, Model {
    static var schema: String = "user"

    var id: Int?

    var firstname: String?

    var lastname: String?

    var email: String = ""

    @Children(for: \Todo.$author)
    var todos: [Todo]

    init() { }
}
