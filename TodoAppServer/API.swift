
import Foundation
import LeoQL

enum API: Schema {
    typealias ViewerContext = Void

    class Query: QueryType {
        func todos(first: Int?, last: Int?, after: String?, before: String?) -> [Todo] {
            return [
                Todo(title: "Learn GraphQL",
                     completed: true),
                Todo(title: "Learn React",
                     completed: false),
            ]
        }

        required convenience init(viewerContext context: Void) {
            self.init()
        }
    }

    typealias Mutation = None
}
