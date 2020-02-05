//
//  main.swift
//  BasicGraphQLTestServer
//
//  Created by Mathias Quintero on 04.02.20.
//  Copyright © 2020 Mathias Quintero. All rights reserved.
//

import Foundation
import LeoQL

struct User : Object {
    let name: String
}

struct Todo : Object {
    let title: String
    let completed: Bool
    let author: User
}

var allTodos = [
    Todo(title: "Learn GraphQL",
         completed: true,
         author: User(name: "Mathias")),
    Todo(title: "Learn React",
         completed: false,
         author: User(name: "Paul")),
]

enum API: Schema {
    typealias ViewerContext = Void

    struct Query {
        let todos: [Todo]
    }

    typealias Mutation = None
}

extension API.Query : QueryType {

    init(viewerContext context: Void) {
        todos = allTodos
    }

}

do {
    let query = """
    query {
        todos {
            title
            author {
                name
            }
        }
    }
    """

    let result = try API.perform(request: query).wait()
    print(result)
} catch {
    print(error)
}
