import Foundation
import UIKit

class User {
    
    var fullName: String
    var profileImage: UIImage
    var status: String
    
    init(fullName: String, profileImage: UIImage, status: String) {
        self.fullName = fullName
        self.profileImage = profileImage
        self.status = status
    }
}

let emptyImage = UIImage()
let emptyUser = User(fullName: "", profileImage: emptyImage, status: "")
let emptyCurrentUser = CurrentUserService(user: emptyUser)


protocol UserService {
    
    func findUser(userName: String) -> User
    
}
