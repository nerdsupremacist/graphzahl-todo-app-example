
import Foundation
import LeoQL

enum API: Schema {
    typealias ViewerContext = Void

    class Query: QueryType {
        func todos() -> [Todo] {
            fatalError()
        }

        required convenience init(viewerContext context: Void) {
            self.init()
        }
    }

    typealias Mutation = None
}
