//
//  main.swift
//  BasicGraphQLTestServer
//
//  Created by Mathias Quintero on 04.02.20.
//  Copyright © 2020 Mathias Quintero. All rights reserved.
//

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

    func todos(first: Int) -> [Todo] {
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
        func todos() -> [Todo] {
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
        todos {
            title
            author {
                lastname
                todos(first: 1) {
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
