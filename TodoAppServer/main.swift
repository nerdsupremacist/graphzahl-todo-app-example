
import Foundation
import Vapor

let app = try Application()
let router = try app.make(Router.self)

router.post(Query.self, at: "graphql") { request, query in
    return try API.perform(request: query.query)
}

try app.run()
