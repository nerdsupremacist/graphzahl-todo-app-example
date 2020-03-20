
import Foundation
import Vapor
import FluentSQLiteDriver
import LeoQL
import VaporLeo

let app = Application()

let sqliteConfig = SQLiteConfiguration(storage: .file(path: "db.sqlite"))
let databaseConfigFactory = DatabaseConfigurationFactory.sqlite(sqliteConfig)
app.databases.use(databaseConfigFactory, as: .sqlite)
app.databases.default(to: .sqlite)


app.routes.graphql(use: API.self, includeGraphiQL: true) { $0.db }

try app.run()
