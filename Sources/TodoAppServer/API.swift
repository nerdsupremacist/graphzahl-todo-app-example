
import Foundation
import LeoQL
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

    typealias Mutation = None
}
