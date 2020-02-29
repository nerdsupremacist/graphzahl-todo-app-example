
import Foundation
import LeoQL
import Fluent
import FluentSQLiteDriver

final class Todo: Object, Model {
    static var schema: String = "todo"

    var id: Int?

    var title: String = ""

    var completed: Bool = false

    @Parent(key: "authorID")
    var author: User
}
