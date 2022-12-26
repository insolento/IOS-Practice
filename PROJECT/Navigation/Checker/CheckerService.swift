import Foundation
import FirebaseAuth

protocol CheckerServiceProtocol {
    func checkCredentials(email: String, password: String)
    func singUp(email: String, password: String)
}

class CheckerService: CheckerServiceProtocol {
    func checkCredentials(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authresult, error in
            if authresult == nil {
                if let errorMessage = error?.localizedDescription {
                    if errorMessage == "There is no user record corresponding to this identifier. The user may have been deleted." {
                        NotificationCenter.default.post(name: .newUserEvent, object: nil)
                    } else if errorMessage == "The password is invalid or the user does not have a password." {
                        NotificationCenter.default.post(name: .wrongPasswordEvent, object: nil)
                    } else {
                        NotificationCenter.default.post(name: .wrongInputEvent, object: nil)
                    }
                }
            } else {
                NotificationCenter.default.post(name: .rightPasswordEvent, object: nil)
            }
            
        }
    }
    
    func singUp(email: String, password: String) {
        print(email, password)
        Auth.auth().createUser(withEmail: email, password: password) {responce,error in
            print("Error = \(error)")
            print("Responce = \(responce)")
        }
    }
    
    
}
