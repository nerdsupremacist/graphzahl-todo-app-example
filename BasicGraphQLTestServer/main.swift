
import Foundation
import LeoQL

class User: Object {
    let firstname: String
    let lastname: String
    let email: String?

    init(firstname: String,
         lastname: String,
         email: String?) {

        self.firstname = firstname
        self.lastname = lastname
        self.email = email
    }

    func todos() -> [Todo] {
        return []
    }
}

class Todo: Object {
    let title: String
    let completed: Bool

    init(title: String, completed: Bool) {
        self.title = title
        self.completed = completed
    }

    func author() -> User {
        return User(firstname: "Mathias", lastname: "Quintero", email: "me@quintero.io")
    }
}

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

do {
    let query = """
    query {
        todos(first: 5) {
            title
            author {
                name
                todos {
                    title
                }
            }
        }
    }
    """

    let result = try API.perform(request: query).wait()
    print(result)
} catch {
    print(error)
}
