
import Foundation
import LeoQL
import Fluent
import FluentSQLiteDriver

class User: Object, Model {
    static var schema: String = "user"

    @ID
    var id: UUID?

    @Field(key: "firstname")
    var firstname: String?

    @Field(key: "lastname")
    var lastname: String?

    @Field(key: "email")
    var email: String

    @Children(for: \Todo.$author)
    var todos: [Todo]

    required init() { }
}
