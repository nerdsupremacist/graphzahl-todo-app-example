
import Foundation
import LeoQL
import Fluent
import FluentSQLiteDriver

class Todo: Object, Model {
    static var schema: String = "todo"

    @ID
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "completed")
    var completed: Bool

    @Parent(key: "authorID")
    var author: User

    required init() {}
}
