
import Foundation
import LeoQL

enum UserRole: String, GraphQLEnum, Codable {
    case admin
    case moderator
    case user
}
