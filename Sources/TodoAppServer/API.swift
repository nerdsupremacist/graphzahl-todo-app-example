
import Foundation
import LeoQL
import Vapor
import NIO
import Fluent

enum API: LeoQL.Schema {
    typealias ViewerContext = Request

    class Query: QueryType {
        let request: Request

        func todos() -> QueryBuilder<Todo> {
            return Todo.query(on: request.db)
        }

        func users() -> QueryBuilder<User> {
            return User.query(on: request.db)
        }

        required init(viewerContext request: Request) {
            self.request = request
        }
    }

    typealias Mutation = None
}
