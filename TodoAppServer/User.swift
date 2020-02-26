
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

    func todos() -> [Todo] {
        return []
    }
}
