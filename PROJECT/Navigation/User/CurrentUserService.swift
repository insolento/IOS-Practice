import Foundation
import UIKit

class CurrentUserService: UserService {
    
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func findUser(userName: String) -> User {
        if userName == user.fullName {
            return user
        } else {
            return emptyUser
        }
    }
}
