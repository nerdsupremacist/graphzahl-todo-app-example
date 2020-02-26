
import Foundation
import Vapor
import FluentSQLite

var services = Services.default()
let sqlite = try SQLiteDatabase(storage: .file(path: "db.sqlite"))

/// Register the configured SQLite database to the database config.
var databases = DatabasesConfig()
databases.add(database: sqlite, as: .sqlite)
services.register(databases)

let app = try Application(services: services)
let router = try app.make(Router.self)

router.post(Query.self, at: "graphql") { request, query in
    return try API.perform(request: query.query)
}

try app.run()
