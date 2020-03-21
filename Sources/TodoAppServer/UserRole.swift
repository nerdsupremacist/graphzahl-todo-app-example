
import Foundation
import GraphZahl

enum UserRole: String, GraphQLEnum, Codable {
    case admin
    case moderator
    case user
}
