
import Foundation
import Vapor
import FluentSQLiteDriver
import GraphZahl
import GraphZahlVaporSupport
import GraphZahlFluentSupport

let app = Application()

let sqliteConfig = SQLiteConfiguration(storage: .file(path: "db.sqlite"))
let databaseConfigFactory = DatabaseConfigurationFactory.sqlite(sqliteConfig)
app.databases.use(databaseConfigFactory, as: .sqlite)
app.databases.default(to: .sqlite)

app.migrations.add(User.Migration())
app.migrations.add(Todo.Migration())

try app.autoMigrate().wait()
app.routes.graphql(use: API.self, includeGraphiQL: true) { $0.db }
try app.run()
