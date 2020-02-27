
import Foundation
import LeoQL
import Fluent

enum API: Schema {
    typealias ViewerContext = DatabaseConnectable

    class Query: QueryType {
        let context: DatabaseConnectable

        func todos() -> Future<[Todo]> {
            return TodoModel
                .query(on: context)
                .all()
                .map { $0.map { Todo(connectable: self.context, todo: $0) } }
        }

        required init(viewerContext context: DatabaseConnectable) {
            self.context = context
        }
    }

    typealias Mutation = None
}
