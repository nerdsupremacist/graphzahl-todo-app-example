
import Foundation
import GraphZahl
import Fluent
import FluentSQLiteDriver

class Todo: GraphQLObject, Model {
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

    init(title: String, completed: Bool = false, authorId: UUID) {
        self.title = title
        self.completed = completed
        self.$author.id = authorId
    }
}

extension Todo {

    struct Migration: Fluent.Migration {
        var name: String {
            return "TodoMigration"
        }

        func prepare(on database: Database) -> EventLoopFuture<Void> {
            return database
                .schema(Todo.schema)
                .id()
                .field("title", .string, .required)
                .field("completed", .bool, .required)
                .field("authorID", .uuid, .required)
                .create()
        }

        func revert(on database: Database) -> EventLoopFuture<Void> {
            return database
                .schema(User.schema)
                .delete()
        }

    }

}
