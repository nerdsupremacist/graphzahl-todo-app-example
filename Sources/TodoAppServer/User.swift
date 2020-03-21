
import Foundation
import GraphZahl
import Fluent
import FluentSQLiteDriver

class User: GraphQLObject, Model {
    static var schema: String = "user"

    @ID
    var id: UUID?

    @Field(key: "role")
    var role: UserRole

    @Field(key: "name")
    var name: String?

    @Field(key: "email")
    var email: String

    @Children(for: \Todo.$author)
    var todos: [Todo]

    required init() { }
}

extension User {

    struct Migration: Fluent.Migration {
        var name: String {
            return "UserMigration"
        }

        func prepare(on database: Database) -> EventLoopFuture<Void> {
            return database
                .schema(User.schema)
                .id()
                .field("role", .string, .required)
                .field("name", .string)
                .field("email", .string, .required)
                .create()
        }

        func revert(on database: Database) -> EventLoopFuture<Void> {
            return database
                .schema(User.schema)
                .delete()
        }

    }

}
