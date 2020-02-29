
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

app.routes.graphql(path: "graphql", use: API.self) { $0 }

try app.run()
