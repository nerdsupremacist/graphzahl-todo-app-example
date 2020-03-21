
import Foundation
import GraphZahl
import Vapor
import NIO
import Fluent

enum API: GraphQLSchema {
    typealias ViewerContext = Database

    class Query: QueryType {
        let database: Database

        func todos() -> QueryBuilder<Todo> {
            return Todo.query(on: database)
        }

        func users(roles: [UserRole] = UserRole.allCases) -> QueryBuilder<User> {
            return User.query(on: database).filter(\.$role ~~ roles)
        }

        required init(viewerContext database: Database) {
            self.database = database
        }
    }

    class Mutation: MutationType {
        let database: Database

        func toggle(todoId: UUID) -> EventLoopFuture<Todo> {
            let todo = Todo.query(on: database).filter(\.$id == todoId).first()
            return todo
                .flatMap { (todo: Todo?) -> EventLoopFuture<Todo> in
                    guard let todo = todo else {
                        return self.database.eventLoop.makeFailedFuture(FluentError.noResults)
                    }

                    todo.completed = !todo.completed
                    return todo.update(on: self.database).map { todo }
                }
        }

        func toggleAll(completed: Bool, authorId: UUID?) -> EventLoopFuture<QueryBuilder<Todo>> {
            let query = Todo.query(on: database)

            if let authorId = authorId {
                query.filter(\.$author.$id == authorId)
            }

            return query.set(\.$completed, to: completed).update().map { query }
        }

        func createTodo(title: String, completed: Bool = false, authorId: UUID) -> EventLoopFuture<Todo> {
            let todo = Todo()
            todo.title = title
            todo.completed = completed
            todo.$author.id = authorId
            return todo.create(on: database).map { todo }
        }

        func registerUser(email: String, name: String?, role: UserRole) -> EventLoopFuture<User> {
            let user = User()
            user.email = email
            user.name = name
            user.role = role
            return user.create(on: database).map { user }
        }

        required init(viewerContext database: Database) {
            self.database = database
        }
    }
}
