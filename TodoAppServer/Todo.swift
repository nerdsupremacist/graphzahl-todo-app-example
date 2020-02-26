
import Foundation
import LeoQL

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
