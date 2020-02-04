//
//  main.swift
//  BasicGraphQLTestServer
//
//  Created by Mathias Quintero on 04.02.20.
//  Copyright © 2020 Mathias Quintero. All rights reserved.
//

import Foundation
import LeoQL
import GraphQL
import NIO

struct User : Object {
    let name: String
}

struct Todo : Object {
    let title: String
    let author: User
}

enum MySchema: Schema {
    struct Query : Object {
        let todos: [Todo]
    }
    
    typealias Mutation = Never
}

do {
    let schema = try MySchema.resolve()
    let value = MySchema.Query(todos: [
        Todo(title: "Learn GraphQL",
             author: User(name: "Mathias")),
        Todo(title: "Learn React",
             author: User(name: "Paul")),
    ])
    
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
    let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    let result = try graphql(schema: schema, request: query, rootValue: value, eventLoopGroup: eventLoopGroup).wait()
    print(result)
} catch {
    print(error)
}
